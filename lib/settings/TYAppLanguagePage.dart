/*
 * Author : Johnny Cheung
 * Page: 设置页面 -> app语言设置
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:truthywallet/utility/NotificationCenter.dart';
import 'package:truthywallet/utility/UserDefaults.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';
import 'package:truthywallet/utility/widgets/ImageUtil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TYAppLanguagePage extends StatefulWidget {
  TYAppLanguagePage();

  @override
  _TYAppLanguagePageState createState() => _TYAppLanguagePageState();

  static void open(BuildContext context) {
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (_) => TYAppLanguagePage(),
      ),
    );
  }
}

class _TYAppLanguagePageState extends State<TYAppLanguagePage> {
  String _currentLanguage = "";

  @override
  void initState() {
    super.initState();
    _setData();
  }

  void _setData() async {
    final language = await UserDefaults.getString(kCurrentSelectedLanguageKey) ?? "English";
    setState(() {
      _currentLanguage = language;
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
        middle: Text(AppLocalizations.of(context)!.languageSettings),
        // trailing:,
        // border: Border(bottom: BorderSide(color: Colors.transparent)),
      ),
      body: ListView(
        children: <Widget>[
          _createListTile("English", true),
          _createListTile("Deutsch", false),
        ],
      ),
    );
    return pageScaffold;
  }

  Widget _createListTile(String title, bool isSelected) {
    final container = Container(
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
              title,
              style: TextStyle(
                fontSize: 16,
                color: PublicColors.pureBlack,
              ),
            ),
          ),
          trailing: Container(
            child: Icon(
              Icons.check,
              color: _currentLanguage == title ? PublicColors.mainBlue : Colors.white,
            ),
          ),
        ),
    );
    return GestureDetector(child: container, onTap: () {
      UserDefaults.setString(kCurrentSelectedLanguageKey, title);
      setState(() {
        _currentLanguage = title;
      });
      var langCode = "en";
      if (title == "English") {
        langCode = "en";
      } else if (title == "Deutsch") {
        langCode = "de";
      }
      UserDefaults.setString(kCurrentSelectedLanguageCodeKey, langCode);
      NotificationCenter().post(name: NotificationCenterNotifierName.languageChanged, parameter: {"code":langCode});
    });
  }
}
