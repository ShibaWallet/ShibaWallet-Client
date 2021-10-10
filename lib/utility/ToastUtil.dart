

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:truthywallet/utility/common/PublicColors.dart';

class ToastUtil {

  static void showWith({required String message, ToastGravity gravity = ToastGravity.CENTER, int seconds = 1}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: gravity,
        timeInSecForIosWeb: seconds,
        backgroundColor: PublicColors.mainBlack,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static void show({required String message, ToastPositionUtil position = ToastPositionUtil.center, int seconds = 1}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: _getGravityType(position),
        timeInSecForIosWeb: seconds,
        backgroundColor: PublicColors.mainBlack,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  static ToastGravity _getGravityType(ToastPositionUtil position) {
    if (position == ToastPositionUtil.top) {
      return ToastGravity.TOP;
    } else if (position == ToastPositionUtil.center) {
      return ToastGravity.CENTER;
    } else if (position == ToastPositionUtil.down) {
      return ToastGravity.BOTTOM;
    }
    return ToastGravity.CENTER;
  }

}

enum ToastPositionUtil {
  top,
  center,
  down,
}
