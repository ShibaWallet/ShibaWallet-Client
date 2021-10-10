import 'package:shared_preferences/shared_preferences.dart';



// 当前选中的钱包地址
const String kCurrentSelectedWalletKey = "kCurrentSelectedWalletKey";
// 当前选中的钱包地址所属公链Id
const String kCurrentSelectedWalletOnChainIdKey = "kCurrentSelectedWalletOnChainIdKey"; 



/// 设置页的一些本地缓存配置 --> begin

// 当前选中的法定货币类型
const String kCurrentSelectedCurrencyKey = "kCurrentSelectedCurrencyKey";
// 当前是否开启Push推送
const String kCurrentOpenPushNotificationsKey = "kCurrentOpenPushNotificationsKey";

// 当前选择的语言
const String kCurrentSelectedLanguageKey = "kCurrentSelectedLanguageKey";
// 当前选择的语言code
const String kCurrentSelectedLanguageCodeKey = "kCurrentSelectedLanguageCodeKey";






class UserDefaults {

  static Future<bool> containsKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

  static Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  static void setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static void setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    try {
      return prefs.getString(key);
    } catch (e) {
      return null;
    }
  }

  static void setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  static Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

}

