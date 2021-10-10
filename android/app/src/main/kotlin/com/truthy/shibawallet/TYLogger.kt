package com.truthy.shibawallet

import android.content.Context
import com.umeng.analytics.MobclickAgent

// 友盟接入文档：https://developer.umeng.com/docs/119267/detail/118637

class TYLogger {

    fun log(context: Context, data: Any?) : String {
        val dataDict = data as Map<String, Any>? ?: return ""
        val eventType = dataDict.get("eventType") as String? // 值有：event, login, logout
        val event = dataDict.get("event") as String?
        val parameters = dataDict.get("data") as Map<String, Any>?
        if (event == null || eventType == null) {
            return ""
        }
        if (eventType == "event") {
            sendEvent(context, event, parameters)
        } else if (eventType == "login") {
            val userId = dataDict.get("userId") as String?
            if (userId != null) {
                login(userId)
            }
        } else if (eventType == "logout") {
            logout()
        }
        return ""
    }

    fun sendEvent(context: Context, event: String, data: Map<String, Any>?) {
        if (data?.size == 0) {
            MobclickAgent.onEvent(context, event);
        } else {
            MobclickAgent.onEventObject(context, event, data);
        }
    }

    fun login(userUniqueID: String) {
        //当用户使用自有账号登录时，可以这样统计：
        MobclickAgent.onProfileSignIn(userUniqueID);
    }

    fun logout() {
        //登出
        MobclickAgent.onProfileSignOff();
    }

}
