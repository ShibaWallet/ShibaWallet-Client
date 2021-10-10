/*
 * Author : Johnny Cheung
 * Page: NFT资产页面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:truthywallet/Core/Database/TYWalletDB.dart';
import 'package:truthywallet/Core/Database/TYWalletModel.dart';
import 'package:truthywallet/Core/Network/TYHttpRequester.dart';
import 'package:truthywallet/nft_assets/TYNFTAssetDetailsPage.dart';
import 'package:truthywallet/nft_assets/models/TYNFTAssetItemModel.dart';
import 'package:truthywallet/utility/NotificationCenter.dart';
import 'package:truthywallet/utility/ToastUtil.dart';
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/AmountUtil.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/common/Screen.dart';
import 'package:truthywallet/utility/core/EncryptUtil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYNFTAssetsPage extends StatefulWidget {
  @override
  TYNFTAssetsPageState createState() => TYNFTAssetsPageState();
}

class TYNFTAssetsPageState extends State<TYNFTAssetsPage> {
  bool _showAsGridView = true; // 使用GridView或者ListView显示
  bool _noDataDisplay = false; // 默认假设是有数据的，经过网路请求后再定是否显示空白页面

  late List<TYNFTAssetItemModel> nftAssets = [];
  double _progressIndicatorOpacity = 0.0;

  late List<TYWalletModel> _walletAddressList = [];
  late TYWalletModel _selectedModel = TYWalletModel();

  @override
  void initState() {
    super.initState();
    _setData(true);

    // 监听内部通知事件
    NotificationCenter().subscribe(
      name: NotificationCenterNotifierName.tabBarChange,
      callback: (parameter) => _tabBarChangedSubscriber(parameter),
    );
  }

  /// 通知事件：tab切换
  void _tabBarChangedSubscriber(Map<String, dynamic> parameter) async {
    final index = parameter["index"] as int?;
    if (index != null) {
      if (index == 1) {
        _setData(false);
        // 查询用户选中的钱包地址
        final addr0 = _selectedModel.walletAddress;
        final addr1 = await UserDefaults.getString(kCurrentSelectedWalletKey);
        final selectedWalletChainId = await UserDefaults.getInt(kCurrentSelectedWalletOnChainIdKey);
        if (addr1 != addr0) {
          // 证明用户切换了钱包地址，则去刷新数据
          setState(() {
            final l = _walletAddressList.where((e) => e.walletAddress == addr1 && e.chainId == selectedWalletChainId);
            if (l.length > 0) {
              _selectedModel = l.first;
            }
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget cardView;
    if (_noDataDisplay) {
      cardView = _createEmptyDataDisplay();
    } else {
      if (_showAsGridView) {
        cardView = StaggeredGridView.countBuilder(
          padding: EdgeInsets.only(left: 18, top: 7, right: 18),
          crossAxisCount: 4,
          itemCount: nftAssets.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: MyNFTCardWidget(
                itemModel: nftAssets[index],
              ),
              onTap: () => TYNFTAssetDetailsPage.openPage(
                  context, _selectedModel.chainId, nftAssets[index]),
            );
          },
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          //index.isEven ? 4 : 3
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        );
      } else {
        final l = ListView.separated(
          itemBuilder: (BuildContext context, int index) {
            final m = nftAssets[index];
            final tokenId = "#${m.tokenId}";
            final c = Container(
              height: 85,
              color: PublicColors.pureWhite,
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 15, top: 15),
                leading: Container(
                  child: TYNFTResourceDisplay.createImageNFT(m.nftUrl ?? ""),
                  width: 50,
                  height: 50,
                ),
                title: _createTitle(tokenId, m.tokenName ?? ""),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 5),
                  child: Text(m.nftDesc ?? ""),
                ),
              ),
            );
            return GestureDetector(
              child: c,
              onTap: () => TYNFTAssetDetailsPage.openPage(
                  context, _selectedModel.chainId, nftAssets[index]),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Container(
              margin: EdgeInsets.only(left: 80),
              color: PublicColors.grayBackground,
              height: 1,
            );
          },
          itemCount: nftAssets.length,
        );
        cardView = Container(
          child: l,
          margin: EdgeInsets.only(top: 20),
        );
      }
    }

    var pageScaffold = Scaffold(
      backgroundColor: PublicColors.grayBackground,
      appBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        middle: Text(
          AppLocalizations.of(context)!.myNFTs,
          style: TextStyle(fontSize: 18),
        ),
        trailing: GestureDetector(
          child: Container(
            width: 44,
            height: 44,
            child: Icon(
              _showAsGridView ? Icons.grid_view : Icons.view_list,
              size: 23,
              color: PublicColors.mainBlack,
            ),
          ),
          onTap: () => changeViewDisplayMode(),
        ),
        border: Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            width: 0.5,
            color: PublicColors.grayNavLine,
          ),
        ),
      ),
      body: Stack(
        children: [
          cardView,
          AnimatedOpacity(
            opacity: _progressIndicatorOpacity,
            duration: Duration(milliseconds: 300),
            child: Center(
              child: Container(
                child: CircularProgressIndicator(
                  color: PublicColors.mainBlue,
                ),
                height: 44.0,
                width: 44.0,
              ),
            ),
          ),
        ],
      ),
    );
    return pageScaffold;
  }

  Widget _createTitle(String tokenId, String tokenName) {
    return Row(
      children: [
        Text(tokenName),
        Container(
          margin: EdgeInsets.only(left: 10),
          height: 18,
          width: _getTokenIdWidth(tokenId),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            gradient: LinearGradient(
              colors: [PublicColors.mainOrange, PublicColors.mainOrange3],
              // begin: const FractionalOffset(0.0, 0.5),
              // end: const FractionalOffset(0.5, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Text(
            tokenId,
            style: TextStyle(fontSize: 13, color: PublicColors.pureWhite),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _createEmptyDataDisplay() {
    final plainAddr = _decryptWalletAddress(_selectedModel.walletAddress ?? "");
    final shortPlainAddr = AmountUtil.getShortAddressByPlaces(plainAddr, 6);
    return Center(
      child: Container(
        width: 200,
        height: 400,
        child: Column(
          children: [
            Image.asset("assets/images/empty_nftart_product.png"),
            Container(
              height: 25,
              child: Text(
                AppLocalizations.of(context)!.yourAddress + " :",
                style: TextStyle(color: PublicColors.grayTitle, fontSize: 14),
              ),
            ),
            Container(
              height: 25,
              child: Text(
                "$shortPlainAddr",
                style: TextStyle(color: PublicColors.grayTitle, fontSize: 14),
              ),
            ),
            Container(
              height: 40,
              child: Text(
                AppLocalizations.of(context)!.yourNFTArtsWillBeShownHere,
                style: TextStyle(
                  color: PublicColors.grayTitle,
                  fontSize: 14,
                  fontWeight: FontWeight.w500, 
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setData(bool showProgressBar) async {
    // 1.从本地数据库查询钱包列表
    await TYWalletDB.getInstance.open();
    final walletAddressList = await TYWalletDB.getInstance.queryWalletAddress();
    await TYWalletDB.getInstance.close();
    _walletAddressList = walletAddressList;

    // 2.查询用户选中的钱包地址
    final selectedWalletAddress =
        await UserDefaults.getString(kCurrentSelectedWalletKey);
    final selectedWalletChainId = await UserDefaults.getInt(kCurrentSelectedWalletOnChainIdKey);
    if (walletAddressList.length > 0 && selectedWalletAddress != null) {
      _selectedModel = walletAddressList
          .firstWhere((e) => e.walletAddress == selectedWalletAddress && e.chainId == selectedWalletChainId);
    }

    final walletAddress = _selectedModel.walletAddress;
    if (walletAddress == null || walletAddress.length == 0) {
      setNoDataDisplayTrue();
      return;
    }
    final plainWalletAddress = _decryptWalletAddress(walletAddress);
    if (plainWalletAddress.length == 0) {
      setNoDataDisplayTrue();
      return;
    }
    if (nftAssets.length == 0 && showProgressBar) {
      setState(() {
        _progressIndicatorOpacity = 1.0;
      });
    }
    // 3.查询设置的法定火币类型
    TYHttpRequester.queryMyNFTsHolding(
        _selectedModel.chainId, plainWalletAddress, (isSuccess, error, data) {
      if (nftAssets.length == 0 && showProgressBar) {
        setState(() {
          _progressIndicatorOpacity = 0.0;
        });
      }
      if (!isSuccess || error != null) {
        // ToastUtil.show(
        //     message: error ??
        //         "Query command unknown error! Contact support@shibawallet.pro please.");
        setState(() {
          nftAssets = [];
          _noDataDisplay = true;
        });
        return;
      }
      if (data == null) {
        setNoDataDisplayTrue();
        return;
      }
      setState(() {
        _noDataDisplay = false;

        nftAssets = [];
        data.forEach((e) {
          nftAssets.add(TYNFTAssetItemModel.fromJson(e));
        });
      });
    });
  }

  setNoDataDisplayTrue() {
    setState(() {
      _noDataDisplay = true;
    });
  }

  void changeViewDisplayMode() {
    _showAsGridView = !_showAsGridView;
    setState(() {});
    if (_showAsGridView) {
    } else {}
  }

  String _decryptWalletAddress(String addr) {
    return EncryptUtil.decryptByAES(
        encryptedText: addr, bizType: EncryptBizType.walletAddress);
  }

  @override
  void dispose() {
    super.dispose();
    print("TYNFTAssetsPage::dispose");
  }
}

class MyNFTCardWidget extends StatefulWidget {
  final TYNFTAssetItemModel itemModel;
  MyNFTCardWidget({Key? key, required this.itemModel});

  @override
  State<StatefulWidget> createState() => _MyNFTCardWidgetState();
}

class _MyNFTCardWidgetState extends State<MyNFTCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    print("_MyNFTCardWidgetState disposed");
  }

  @override
  Widget build(BuildContext context) {
    final margin = 10;
    final cardWidth = (Screen.width(context) - margin * 2) / 2;
    // final cardHeight = cardWidth + 50;
    final tokenId = "#" + widget.itemModel.tokenId.toString();
    final nftDesc = widget.itemModel.nftDesc ?? "";
    final tokenDesc = nftDesc.length > 0 ? nftDesc : widget.itemModel.tokenName;
    final container = Container(
      width: cardWidth,
      // height: cardHeight,
      color: PublicColors.pureWhite,
      margin: EdgeInsets.only(left: 3, top: 14, right: 3),
      child: Column(
        children: [
          TYNFTResourceDisplay.createImageNFT(widget.itemModel.nftUrl ?? "",
              cardWidth: cardWidth),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(top: 10, left: 10),
              height: 18,
              width: _getTokenIdWidth(tokenId),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(3)),
                gradient: LinearGradient(
                  colors: [PublicColors.mainOrange, PublicColors.mainOrange3],
                  // begin: const FractionalOffset(0.0, 0.5),
                  // end: const FractionalOffset(0.5, 0.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp,
                ),
              ),
              child: Text(
                tokenId,
                style: TextStyle(fontSize: 13, color: PublicColors.pureWhite),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, top: 8, right: 5, bottom: 10),
            // height: 25,
            alignment: Alignment.centerLeft,
            child: Text(
              tokenDesc ?? "",
              style: TextStyle(fontSize: 14.5),
            ),
          ),
        ],
      ),
    );
    return container;
  }
}

double _getTokenIdWidth(String tokenId) {
  final unit = 50.0 / 6.0;
  return unit * tokenId.length + 8;
}
