/*
 * Author : Johnny Cheung
 * Page: 设置页面 -> 推送通知
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/widgets/ImageUtil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYPushNotificationsPage extends StatefulWidget {
  TYPushNotificationsPage();

  @override
  _TYPushNotificationsPageState createState() =>
      _TYPushNotificationsPageState();

  static void open(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYPushNotificationsPage(),
      ),
    );
  }
}

class _TYPushNotificationsPageState extends State<TYPushNotificationsPage> {
  bool _isOpen = true;

  @override
  void initState() {
    super.initState();
    _setData();
  }

  void _setData() async {
    final isOpen =
        await UserDefaults.getBool(kCurrentOpenPushNotificationsKey) ?? true;
    setState(() {
      _isOpen = isOpen;
    });
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
        middle: Text(AppLocalizations.of(context)!.pushNotifications),
        // trailing:,
        // border: Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, top: 20, right: 20),
            decoration: BoxDecoration(
              color: PublicColors.pureWhite,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
            child: ListTile(
              title: Container(
                margin: EdgeInsets.only(left: 5),
                child: Text(
                  AppLocalizations.of(context)!.allowPushNotifications,
                  style: TextStyle(
                    fontSize: 16,
                    color: PublicColors.pureBlack,
                  ),
                ),
              ),
              trailing: Container(
                child: CupertinoSwitch(
                  value: _isOpen,
                  onChanged: (bool value) {
                    UserDefaults.setBool(
                        kCurrentOpenPushNotificationsKey, value);
                    setState(() {
                      _isOpen = !_isOpen;
                    });
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return pageScaffold;
  }
}
