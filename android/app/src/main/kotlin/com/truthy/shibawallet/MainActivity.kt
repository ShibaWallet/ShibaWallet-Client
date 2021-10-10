package com.truthy.shibawallet

import android.os.Bundle
import androidx.annotation.NonNull
import com.umeng.commonsdk.UMConfigure
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {

    private val ChannelName = "com.truthy.shibawallet/flutter/methodchannel"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        UMConfigure.preInit(this, "6123052e5358984f59b241fd", "ShibaWallet")
        // UMConfigure.setLogEnabled(true)
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, ChannelName).setMethodCallHandler {
                call, result ->
            // Note: this method is invoked on the main thread.
           if (call.method == "WalletOperate") {
               val r = TrustWalletFlutterMethodChannelHandler.getInstance.handle(call.arguments)
               result.success(r.toDict())
           } else if (call.method == "Logger") {
               TYLogger().log(context, call.arguments)
               result.success("")
           } else {
               result.error("UNAVAILABLE", "The ${call.method} method unavailable!", null)
           }
        }
    }


}
