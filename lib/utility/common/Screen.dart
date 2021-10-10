import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/widgets.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1

class Screen {
  
  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;
  //PIXELS
  static Size size(BuildContext context) => MediaQuery.of(context).size;

  static double width(BuildContext context) => size(context).width;

  static double height(BuildContext context) => size(context).height;

  static double diagonal(BuildContext context) {
    final Size s = size(context);
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  //INCHES
  static Size inches(BuildContext context) {
    final Size pxSize = size(context);
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext context) => inches(context).width;

  static double heightInches(BuildContext context) => inches(context).height;

  static double diagonalInches(BuildContext context) =>
      diagonal(context) / _ppi;
}

extension MediaQueryExtension on BuildContext {
  Size get size => Screen.size(this);
  double get height => Screen.size(this).height;
  double get width => Screen.size(this).width;
}

double devicePixelRatio = window.devicePixelRatio;

///根据手机的分辨率从 dp 的单位 转成为 px(像素)
int pxValueOfPx(double dpValue) {
  return (dpValue * devicePixelRatio).toInt();
}

///根据手机的分辨率从 px 的单位 转成为 dp
int dpValueOfPx(double dpValue) {
  return (dpValue * devicePixelRatio).toInt();
}

/// 按照iOS标注图(375pt)开发，计算对应平台的实际值
///
/// 主要用于各种widget布局时，字体大小、宽高、内外边距等的计算
///
/// ```dart
/// TextStyle(fontSize: valueOfPt(13))
/// ```
///
/// ```dart
/// Padding(padding: EdgeInsets.all(valueOfPt(15)))
/// ```
///
/// See also:
///
/// * [fontSize]、[width]、[height]、[margin]、[padding]、[EdgeInsets]、[size]......
///
double valueOfPt(double ptValue, {bool isRoundToDouble = false}) {
  if (Platform.isIOS) {
    return ptValue;
  } else {
    return isRoundToDouble
        ? (ptValue * 2 * 1.44 / 3)
        : (ptValue * 2 * 1.44 / 3).roundToDouble();
  }
}

/// 按照Android标注图(360dp)开发，计算对应平台的实际值
///
/// 主要用于各种widget布局时，字体大小、宽高、内外边距等的计算
///
/// ```dart
/// TextStyle(fontSize: valueOfDp(13))
/// ```
///
/// ```dart
/// Padding(padding: EdgeInsets.all(valueOfDp(15)))
/// ```
///
/// See also:
///
/// * [fontSize]、[width]、[height]、[margin]、[padding]、[EdgeInsets]、[size]......
///
double valueOfDp(double dpValue) {
  if (Platform.isAndroid) {
    return dpValue;
  } else {
    return (dpValue * 3 / 1.44 / 2).roundToDouble();
  }
}
