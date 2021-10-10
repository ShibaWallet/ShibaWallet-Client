import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    UMConfigure.initWithAppkey("61192dc51fee2e303c22b880", channel: "App Store")
    
    
    if let controller : FlutterViewController = window?.rootViewController as? FlutterViewController {
        let methodChannel = FlutterMethodChannel(name: "com.truthy.shibawallet/flutter/methodchannel", binaryMessenger: controller.binaryMessenger)
        methodChannel.setMethodCallHandler({
          (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
          // Note: this method is invoked on the UI thread.
            if call.method == "WalletOperate" {
                let ret = TrustWalletFlutterMethodChannelHandler.getInstance().handle(dict: call.arguments)
                result(ret.toDict())
                return
            } else if call.method == "Logger" {
                TYLogger.send(data: call.arguments)
                result(0)
                return
            }
            result(FlutterMethodNotImplemented)
        })
    }
    
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
