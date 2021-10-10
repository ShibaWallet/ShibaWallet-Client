import 'dart:ui';
import 'package:flutter/material.dart';

class AlertController {

  static void alert(
      {required BuildContext context,
      String? title,
      required String message,
      String confirmTitle = "OK",
      String? cancelTitle,
      VoidCallback? confirmCallback,
      VoidCallback? cancelCallback}) {
    List<Widget> buttons = [];
    Widget okButton = TextButton(
      child: Text(confirmTitle),
      onPressed: () {
        Navigator.pop(context);
        if (confirmCallback != null) {
          confirmCallback();
        }
      },
    );
    buttons.add(okButton);
    if (cancelTitle != null) {
      Widget cancelButton = TextButton(
        child: Text(cancelTitle),
        onPressed: () {
          Navigator.pop(context);
          if (cancelCallback != null) {
            cancelCallback();
          }
        },
      );
      buttons.add(cancelButton);
    }
    AlertDialog alert = AlertDialog(
      title: title == null ? null : Text(title),
      content: Text(message),
      actions: buttons,
    );
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      },
    );
    
  }
}
