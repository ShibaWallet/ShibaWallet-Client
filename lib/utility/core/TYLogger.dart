
/*
 * 友盟Flutter文档：https://developer.umeng.com/docs/119267/detail/174923
 */


import 'package:flutter/services.dart';

class TYLogger {

  static const _methodChannel = const MethodChannel('com.truthy.shibawallet/flutter/methodchannel');

  static Future<void> initUmeng() async {
    // final androidAppkey = "6123052e5358984f59b241fd";
    // final iosAppkey = "61192dc51fee2e303c22b880";
    // final r = await UmengCommonSdk.initCommon(androidAppkey, iosAppkey, "Flutter"); // 报错，不好解决
    // print("友盟SDK初始化成功 r=$r");
  }

  static void sendEvent(String eventName) async {
    final _ = await _methodChannel.invokeMethod('Logger', {"eventType":"event","event":eventName,"data":{}});
  }

  static void sendEventWithArgs(String eventName, Map<String, dynamic> args) async {
    // 发送自定义事件（目前属性值支持字符、整数、浮点、长整数，暂不支持NULL、布尔、MAP、数组）
    final _ = await _methodChannel.invokeMethod('Logger', {"eventType":"event","event":eventName,"data":args});
  }

  static void pageStart(String pageName) {
    // 进入页面统计（手动采集时才可设置）
    // UmengCommonSdk.onPageStart(pageName);
  }

  static void pageEnd(String pageName) {
    // 离开页面统计（手动采集时才可设置）
    // UmengCommonSdk.onPageEnd(pageName);
  }

}
