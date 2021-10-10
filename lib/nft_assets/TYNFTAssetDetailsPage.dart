/*
 * Author : Johnny Cheung
 * Page: NFT资产详情页面
 */

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truthywallet/assets/widgets/TYWalletNetworkType.dart';
import 'package:truthywallet/nft_assets/models/TYNFTAssetItemModel.dart';
import 'package:truthywallet/utility/ToastUtil.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/common/TimeAgoUtil.dart';
import 'package:truthywallet/utility/widgets/ImageUtil.dart';

class TYNFTAssetDetailsPage extends StatelessWidget {
  final TYNFTAssetItemModel itemModel;
  final int chainId;
  TYNFTAssetDetailsPage(
      {Key? key, required this.chainId, required this.itemModel})
      : super(key: key);

  static void openPage(
      BuildContext context, int chainId, TYNFTAssetItemModel itemModel) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) =>
            TYNFTAssetDetailsPage(chainId: chainId, itemModel: itemModel),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var pageScaffold = Scaffold(
      backgroundColor: PublicColors.grayBackground,
      appBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        leading: GestureDetector(
          child: Container(
            width: 44,
            height: 44,
            child: ImageUtil.getBackButtonImage(),
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        ),
        middle: Text(
          itemModel.tokenName ?? "",
          style: TextStyle(fontSize: 18),
        ),
        // border: Border(
        //   bottom: BorderSide(
        //     style: BorderStyle.solid,
        //     width: 0.5,
        //     color: PublicColors.grayNavLine,
        //   ),
        // ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 10),
        children: [
          TYNFTResourceDisplay.createImageNFT(itemModel.nftUrl ?? ""),
          Container(
            height: 15,
            color: PublicColors.grayBackground,
          ),
          GestureDetector(
            child: Container(
              color: PublicColors.pureWhite,
              child: ListTile(
                leading: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    "Token Id :",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                title: Text(
                  "#" + itemModel.tokenId.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: PublicColors.mainBlue),
                ),
              ),
            ),
            onTap: () =>
                _copyAddressToClipBoard(itemModel.contractAddress ?? ""),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Token Name :",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                itemModel.tokenName.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Token Symbol :",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                itemModel.tokenSymbol.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Author Named :",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                itemModel.nftName.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Author Depicted :",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                itemModel.nftDesc.toString(),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 10),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Asset Public Chain:",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                TYWalletNetworkTypeManager.getPublicChainFullName(
                        chainId: chainId) +
                    " (ERC721)",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          Container(
            color: PublicColors.pureWhite,
            margin: EdgeInsets.only(top: 1),
            child: ListTile(
              leading: Container(
                margin: EdgeInsets.only(top: 2),
                child: Text(
                  "Start Holding Date:",
                  style: TextStyle(fontSize: 14),
                ),
              ),
              title: Text(
                TimeAgoUtil.getDateTimeStr(
                    int.parse(itemModel.timeStamp.toString())),
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: PublicColors.mainBlack),
              ),
            ),
          ),
          GestureDetector(
            child: Container(
              color: PublicColors.pureWhite,
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                leading: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    "Contract Address:",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                title: Text(
                  itemModel.contractAddress ?? "",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: PublicColors.mainBlack),
                ),
              ),
            ),
            onTap: () =>
                _copyAddressToClipBoard(itemModel.contractAddress ?? ""),
          ),
          GestureDetector(
            child: Container(
              color: PublicColors.pureWhite,
              margin: EdgeInsets.only(top: 1),
              child: ListTile(
                leading: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    "Owner Address:",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                title: Text(
                  itemModel.toAddress ?? "",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: PublicColors.mainBlack),
                ),
              ),
            ),
            onTap: () =>
                _copyAddressToClipBoard(itemModel.contractAddress ?? ""),
          ),
          GestureDetector(
            child: Container(
              color: PublicColors.pureWhite,
              margin: EdgeInsets.only(top: 1),
              child: ListTile(
                leading: Container(
                  margin: EdgeInsets.only(top: 2),
                  child: Text(
                    "Transaction Hash:",
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                title: Text(
                  itemModel.hash ?? "",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: PublicColors.mainBlack),
                ),
              ),
            ),
            onTap: () =>
                _copyAddressToClipBoard(itemModel.hash ?? ""),
          ),
        ],
      ),
    );
    return pageScaffold;
  }

  void _copyAddressToClipBoard(String addr) {
    Clipboard.setData(ClipboardData(text: addr));
    ToastUtil.showWith(message: "Copied Success", gravity: ToastGravity.TOP, seconds: 1);
  }
}

class TYNFTResourceDisplay {
  static Widget createImageNFT(String nftUrl, {double cardWidth = 0.0}) {
    var image;
    if (nftUrl.length == 0) { 
      image = Center(
        child: Image.asset("assets/images/empty_nftart_product.png"),
      );
    } else {
      image = ClipRRect(
        borderRadius: BorderRadius.circular(4.0),
        child: CachedNetworkImage(
          fit: BoxFit.cover,
          imageUrl: nftUrl,
          placeholder: _getImagePlaceholderLoader,
          errorWidget: _getImagePlaceholderLoadedError,
        ),
      );
    }
    if (cardWidth == 0) {
      return Container(
        child: image,
        color: PublicColors.grayBackground,
      );
    }
    Widget imageNFT = Container(
      width: cardWidth,
      child: image,
    );
    return imageNFT;
  }

  static Widget _getImagePlaceholderLoader(BuildContext context, String url) {
    return Container(
      color: PublicColors.gray,
    );
  }

  static Widget _getImagePlaceholderLoadedError(
      BuildContext context, String url, dynamic error) {
    return Center(
      child: Image.asset("assets/images/empty_nftart_product.png"),
    );
  }
}
