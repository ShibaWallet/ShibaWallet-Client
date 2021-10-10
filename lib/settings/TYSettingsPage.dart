/*
 * Author : Johnny Cheung
 * Page: 设置页面
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:share/share.dart';
import 'package:truthywallet/CommonWidget/TYWebViewWidget.dart';
import 'package:truthywallet/Core/Database/TYWalletDB.dart';
import 'package:truthywallet/Core/Database/TYWalletModel.dart';
import 'package:truthywallet/assets/TYCreateWalletPage.dart';
import 'package:truthywallet/assets/TYWalletNetworkTypeSwitcher.dart';
import 'package:truthywallet/settings/TYAboutPage.dart';
import 'package:truthywallet/settings/TYAppLanguagePage.dart';
import 'package:truthywallet/settings/TYCurrencyChangePage.dart';
import 'package:truthywallet/settings/TYPushNotificationsPage.dart';
import 'package:truthywallet/settings/widgets/TYSettingPageListTileWidget.dart';
import 'package:truthywallet/utility/NotificationCenter.dart';
import 'package:truthywallet/utility/ToastUtil.dart'; 
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/core/TYLogger.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYSettingsPage extends StatefulWidget {
  @override
  TYSettingsPageState createState() => TYSettingsPageState();
}

class TYSettingsPageState extends State<TYSettingsPage> { 

  late List<TYWalletModel> _walletAddressList = [];
  late TYWalletModel _selectedModel = TYWalletModel();
  late String _walletName = "";
  late String _fiatCurrency = "USD";

  @override
  void initState() {
    super.initState(); 
    _setData();

    // 监听内部通知事件
    NotificationCenter().subscribe(
        name: NotificationCenterNotifierName.assetPage,
        callback: (parameter) {
          Future.delayed(Duration(seconds: 1), () {
            _setData();
          });
        },);
    NotificationCenter().subscribe(
        name: NotificationCenterNotifierName.tabBarChange,
        callback: (parameter) => _tabBarChangedSubscriber(parameter),);
  }

  /// 通知事件：tab切换
  void _tabBarChangedSubscriber(Map<String, dynamic> parameter) async {
    final index = parameter["index"] as int?;
    if (index != null) { 
      if (index == 2) {
        _setData();
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
              _walletName = _selectedModel.aliasName ?? "";
            }
          }); 
        }
      }
    }
  } 

  @override
  Widget build(BuildContext context) {
    var pageScaffold = Scaffold(
      backgroundColor: PublicColors.grayBackground,
      appBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        middle: Text(
          AppLocalizations.of(context)!.settings,
          style: TextStyle(fontSize: 18),
        ),
        border: Border(
          bottom: BorderSide(
            style: BorderStyle.solid,
            width: 0.5,
            color: PublicColors.grayNavLine,
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          TYSettingPageListTileWidget(
            index: 0,
            title: AppLocalizations.of(context)!.myWallet,
            trailingTitle: _walletName,
            topMargin: 20,
            needBottomLine: true,
            isTopRadius: true,
            onTap: () => {
              _openMyWallet(),
              TYLogger.sendEvent("OpenMyWallet-Settings")},
          ),
          TYSettingPageListTileWidget(
              index: 1,
              title: AppLocalizations.of(context)!.currency,
              trailingTitle: _fiatCurrency,
              isBottomRadius: true,
              onTap: () => { 
                TYCurrencyChangePage.open(context),
                TYLogger.sendEvent("OpenCurrencyChange")},
          ),
          TYSettingPageListTileWidget(
            index: 0,
            title: AppLocalizations.of(context)!.pushNotifications,
            topMargin: 30,
            needBottomLine: true,
            isTopRadius: true,
            onTap: () => { 
              TYPushNotificationsPage.open(context),
              TYLogger.sendEvent("OpenNotificationChange")}
          ),
          TYSettingPageListTileWidget(
              index: 1,
              title: AppLocalizations.of(context)!.languageSettings,
              isBottomRadius: true,
              onTap: () => {
                TYAppLanguagePage.open(context),
                TYLogger.sendEvent("OpenLanguageChange")}
          ),
          TYSettingPageListTileWidget(
            index: 0,
            title: "Twitter",
            topMargin: 30,
            needBottomLine: true, 
            isTopRadius: true,
            onTap: () => { 
              TYWebViewWidget.open(context, "https://twitter.com/ShibaWalletPro"),
              TYLogger.sendEvent("OpenMyTwitterPage")},
          ),
          TYSettingPageListTileWidget(
              index: 1,
              title: "Telegram",
              needBottomLine: true,
              onTap: () => {TYWebViewWidget.open(context, "https://t.me/ShibaWalletPro"),}),
          TYSettingPageListTileWidget(
              index: 1,
              title: AppLocalizations.of(context)!.emailus,
              isBottomRadius: true,
              onTap: () => _feedbackAlert()),
          TYSettingPageListTileWidget(
              index: 1,
              title: AppLocalizations.of(context)!.about,
              topMargin: 20,
              isTopRadius: true,
              isBottomRadius: true,
              onTap: () => TYAboutPage.open(context),
          ),
        ],
      ),
    );
    return pageScaffold;
  }

  @override
  void dispose() {
    super.dispose();
    // print("TYSettingsPage::dispose");
  }

  void _setData() async {
    // 1.从本地数据库查询创建的钱包列表
    await TYWalletDB.getInstance.open();
    final walletAddressList = await TYWalletDB.getInstance.queryWalletAddress();
    await TYWalletDB.getInstance.close();
    _walletAddressList = walletAddressList; 

    // 2.查询用户选中的钱包地址
    final selectedWalletAddress = await UserDefaults.getString(kCurrentSelectedWalletKey);
    final selectedWalletChainId = await UserDefaults.getInt(kCurrentSelectedWalletOnChainIdKey);
    if (walletAddressList.length > 0 && selectedWalletAddress != null) {
      final foundModels = walletAddressList.where((e) => e.walletAddress == selectedWalletAddress && e.chainId == selectedWalletChainId);
      setState(() {
        _walletName = foundModels.first.aliasName ?? "";
      });
      _selectedModel = foundModels.first;
    }

    // 3.查询设置的法定火币类型
    _fiatCurrency = await UserDefaults.getString(kCurrentSelectedCurrencyKey) ?? "USD";
  }

  void _openCreateWalletPage() {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYCreateWalletPage(showBackButton: true),
      ),
    );
  }

  void _openMyWallet() async {
    TYLogger.sendEvent("open_wallet_on_settings_page");
    // 查询用户选中的钱包
    final selectedWalletAddress = await UserDefaults.getString(kCurrentSelectedWalletKey);
    if (_walletAddressList.length == 0 && selectedWalletAddress == null) {
      // 跳转创建钱包的页面
      _openCreateWalletPage();
      return;
    } 
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYWalletNetworkTypeDetailSwitcher(
          walletAddressList: _walletAddressList, 
          selectedCallback: (selectedModel) { 
            // 设置当前默认选中的钱包
            if (selectedModel.walletAddress != null) {
              // print("个人页切换${selectedModel.walletAddress}");
              UserDefaults.setString(kCurrentSelectedWalletKey, selectedModel.walletAddress ?? "");
              UserDefaults.setInt(kCurrentSelectedWalletOnChainIdKey, selectedModel.chainId);
            }
            setState(() {
              _walletName = selectedModel.aliasName ?? "";
            }); 
            TYLogger.sendEventWithArgs("SettingsPage-SwitchWallet-Done", {"ChainId":selectedModel.chainId});

            EasyLoading.show(status: "Loading", maskType: EasyLoadingMaskType.black, dismissOnTap: false);
            Future.delayed(Duration(seconds: 3), () {
              EasyLoading.dismiss();
            });
          },
        ),
      ),
    );
  }

  void _feedbackAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: null,
        content: new Text(AppLocalizations.of(context)!.writeAnyIdeasOrQuestionsDownTo),
        actions: <Widget>[
          CupertinoDialogAction(
            isDefaultAction: true,
            child: Text(AppLocalizations.of(context)!.copyEmailAddress),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: "support@shibawallet.pro"));
              ToastUtil.showWith(message: AppLocalizations.of(context)!.copiedEmailAddressSuccess);
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            isDestructiveAction: true,
            child: Text(AppLocalizations.of(context)!.sendEmailToUs),
            onPressed: () {
              Navigator.pop(context);
              Share.share('support@shibawallet.pro');
            },
          ),
        ],
      ),
    );
    TYLogger.sendEvent("AlertFeedBack-Settings");
  }

}
