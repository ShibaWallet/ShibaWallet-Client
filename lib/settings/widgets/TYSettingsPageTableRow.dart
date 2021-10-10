import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class TYSettingsPageTableRow {
  late TableRow tableRow;

  final TYSettingRowType rowType;
  final String title;
  final String subtitle;
  final TYSettingRowCornerRadiusDirection cornerRadiusDirection;

  TYSettingsPageTableRow({required this.rowType, required this.title, required this.subtitle, this.cornerRadiusDirection = TYSettingRowCornerRadiusDirection.none});

  TableRow createWidgets() {
    tableRow = TableRow(
      decoration: BoxDecoration(
        color: PublicColors.pureWhite,
        borderRadius: _getBorderCornerRadius(),
      ),
      children: <Widget>[
        // Container(
        //   height: 55,
        //   width: 55,
        //   child: Icon(
        //     _getIconData(),
        //     color: _getIconColor(),
        //   ),
        // ),
        Container(
          height: 55, 
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: PublicColors.grayNavLine, width: 0.5),)
          ),
          child: Text(
            this.title,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          height: 55, 
          alignment: Alignment.centerRight,
          decoration: BoxDecoration( 
            border: Border(bottom: BorderSide(color: PublicColors.grayNavLine, width: 0.5),)
          ),
          child: Text(
            this.subtitle,
            style: TextStyle(fontSize: 16),
          ),
        ),
        Container(
          height: 55,  
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.chevron_right,
            color: PublicColors.grayTitle,
          ),
        ),
      ],
    ); 
    return tableRow;
  }

  static TableRow createSpacer() {
    final tableRow = TableRow(
      decoration: BoxDecoration(
        color: PublicColors.grayBackground,
      ),
      children: <Widget>[
        TableCell(child: Container(height: 28)),
        TableCell(child: Container()),
        TableCell(child: Container()),
        // TableCell(child: Container()),
      ],
    );
    return tableRow;
  }

  // IconData _getIconData() {
  //   if (this.rowType == TYSettingRowType.wallet) {
  //     return Icons.account_balance_wallet_rounded;
  //   }

  //   return Icons.no_encryption;
  // }

  // Color _getIconColor() {
  //   if (this.rowType == TYSettingRowType.wallet) {
  //     return PublicColors.buttonRed;
  //   } else if (this.rowType == TYSettingRowType.currency) {
  //     return PublicColors.buttonRed;
  //   } 

  //   return PublicColors.buttonRed;
  // }

  BorderRadius _getBorderCornerRadius() {
    final radius = Radius.circular(5);
    if (this.cornerRadiusDirection == TYSettingRowCornerRadiusDirection.all) {
      return BorderRadius.all(radius);
    } else if (this.cornerRadiusDirection == TYSettingRowCornerRadiusDirection.up) {
      return BorderRadius.only(topLeft: radius, topRight: radius);
    }  else if (this.cornerRadiusDirection == TYSettingRowCornerRadiusDirection.down) {
      return BorderRadius.only(bottomLeft: radius, bottomRight: radius);
    }
    return BorderRadius.zero;
  }
}


enum TYSettingRowType {
  none,

  wallet,   // 钱包
  currency, // 法定货币类型

  pushNotification, // 通知
  appearance, // 主题外观
  advancedSettings, // 高级设置
  language, // 语言切换

  mail, // 邮件我们
  twitter, 
  telegram,

  about,
}


enum TYSettingRowCornerRadiusDirection {
  none,
  up, // 左上，右上，圆角
  down, // 坐下，右下，圆角
  all, // 全部圆角
}