/*
 * Author : Johnny Cheung
 * Page: App的通知功能
 * 类似iOS中的 NSNotificationCenter，一种发布订阅模式的监听类
 * 第三方的参考：https://pub.dev/packages/flutter_observer
 *
 */

import 'package:truthywallet/utility/libs/dart_notification_center_base.dart';

typedef NotificationCallback = dynamic Function(Map<String, dynamic> parameter);

class NotificationCenter {
  static const String keyName = "name";

  Map<String, List<NotificationCallback>> _callbacks = {};

  NotificationCenter._privateConstructor() {
    //print("NotificationCenter被创建了一次");
  }
  static final NotificationCenter _instance = NotificationCenter._privateConstructor();
  factory NotificationCenter() {
    return _instance;
  }

  void subscribe({required NotificationCenterNotifierName name, required NotificationCallback callback}) {
    final notifyName = NotificationCenterNotifierName.values[name.index].value;
    var callbackList = _callbacks[notifyName];
    if (callbackList == null || callbackList.length == 0) {
      _callbacks[notifyName] = [];
    }
    _callbacks[notifyName]?.add(callback);
  }

  void unsubscribe({required NotificationCenterNotifierName name}) {
    final notifyName = NotificationCenterNotifierName.values[name.index].value;
    _callbacks.remove(notifyName);
  }

  void unsubscribeAll() {
    final notifyNames = NotificationCenterNotifierName.values;
    for (final name in notifyNames) {
      print("移除全部的$name");
      _callbacks.remove(name);
    }
  }

  void post({required NotificationCenterNotifierName name, required Map<String, dynamic> parameter}) {
    final notifyName = NotificationCenterNotifierName.values[name.index].value;
    final notifyCallbacks = _callbacks[notifyName];
    if (notifyCallbacks != null) {
      if (notifyCallbacks.length > 0) {
        notifyCallbacks.forEach((e) => e(parameter));
      } 
    }
  }
}

enum NotificationCenterNotifierName {
  tabBarChange,
  assetPage, // 资产页面
  settingPage, // 设置页面
  transferOutSuccess, // 转出账成功 
  languageChanged, // 修改app语言
}

extension NotificationCenterNotiferNameExtension on NotificationCenterNotifierName {
  String get value => ['tabBarChange', 'assetPage', 'settingPage', 'transferOutSuccess', 'languageChanged'][index];
}




class DartNotificationChannelName {
  
}

void dartPostNotification({required String channel, Map options = const {}}) {
  DartNotificationCenter.post(channel: channel, options: options);
}
