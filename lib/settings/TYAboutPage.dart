/*
 * Author : Johnny Cheung
 * Page: 设置页面 -> 关于
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info/package_info.dart';
import 'package:share/share.dart';
import 'package:truthywallet/CommonWidget/TYWebViewWidget.dart';
import 'package:truthywallet/settings/widgets/TYSettingPageListTileWidget.dart';
import 'package:truthywallet/utility/ToastUtil.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYAboutPage extends StatefulWidget {
  @override
  _TYAboutPageState createState() => _TYAboutPageState();

  static void open(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYAboutPage(),
      ),
    );
  }
}

class _TYAboutPageState extends State<TYAboutPage> {

  String _appVersion = "";
  String _appBuildNo = "";

  @override
  void initState() { 
    super.initState();
    _setData();
  }

  void _setData() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    // String appName = packageInfo.appName;
    // String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    setState(() {
      _appVersion = version;
      _appBuildNo = buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    var pageScaffold = Scaffold(
      backgroundColor: PublicColors.grayBackground,
      appBar: CupertinoNavigationBar(
        backgroundColor: PublicColors.pureWhite,
        padding: EdgeInsetsDirectional.only(start: 8, end: 8),
        middle: Text(
          AppLocalizations.of(context)!.about,
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
            title: AppLocalizations.of(context)!.privacyPolicy,
            topMargin: 20,
            needBottomLine: true,
            isTopRadius: true,
            onTap: () => {TYWebViewWidget.open(context, "https://shibawallet.pro/privacy-and-policy.html"),},
          ),
          TYSettingPageListTileWidget(
            index: 1,
            title: AppLocalizations.of(context)!.termsOfService,
            isBottomRadius: true,
            onTap: () => {TYWebViewWidget.open(context, "https://shibawallet.pro/terms-of-services.html"),},
          ),
          TYSettingPageListTileWidget(
            index: 1,
            title: AppLocalizations.of(context)!.reportOrFeedback,
            topMargin: 20,
            isTopRadius: true,
            isBottomRadius: true,
            onTap: () => _feedbackAlert(),
          ),
          TYSettingPageListTileWidget(
            index: 1,
            title: AppLocalizations.of(context)!.version,
            topMargin: 20,
            trailingTitle: "$_appVersion($_appBuildNo)",
            isTopRadius: true,
            isBottomRadius: true,
            isHiddenTrailingArrow: true,
            onTap: () => {},
          ),
        ],
      ),
    );
    return pageScaffold;
  }

  void _feedbackAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: null,
        content: new Text(AppLocalizations.of(context)!.reportAnyIssuesTo),
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
  }
}
