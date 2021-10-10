/*
 * Author : Johnny Cheung
 * Page: 设置页面 -> 法定货币切换
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/widgets/ImageUtil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYCurrencyChangePage extends StatefulWidget {
  TYCurrencyChangePage();

  @override
  _TYCurrencyChangePageState createState() => _TYCurrencyChangePageState();

  static void open(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYCurrencyChangePage(),
      ),
    );
  }
}

class _TYCurrencyChangePageState extends State<TYCurrencyChangePage> { 

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
        middle: Text(AppLocalizations.of(context)!.currency),
        // trailing:,
        // border: Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(left: 20, top: 20, right: 20),
              decoration: BoxDecoration(
                color: PublicColors.pureWhite,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Icon(
                    Icons.attach_money,
                    color: Colors.green,
                  ),
                ),
                title: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    "USD - US Dollar",
                    style: TextStyle(
                      fontSize: 16,
                      color: PublicColors.pureBlack,
                    ),
                  ),
                ),
                trailing: Container(
                  child: Icon(
                    Icons.check,
                    color: PublicColors.mainBlue,
                  ),
                ),
              ),
            ),
            onTap: () {
              UserDefaults.setString(kCurrentSelectedCurrencyKey, "USD");
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
    return pageScaffold;
  }
}
