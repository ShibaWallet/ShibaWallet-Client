import 'package:flutter/cupertino.dart';

class ImageUtil {

  // 返回按钮的Image图标
  static Image getBackButtonImage({bool isBlackBtn = true, double? width = 25, double? height = 25}) {
    return Image.asset(
      'assets/images/${isBlackBtn ? "black" : "white"}_backslash_arrow.png',
      width: width,
      height: height,
    );
  }

}
