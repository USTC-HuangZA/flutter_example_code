import 'package:shared_preferences/shared_preferences.dart';

class CookieManager{
  static SharedPreferences _prefs;
  static Future init() async{
    CookieManager._prefs = await SharedPreferences.getInstance();
    print('cookie manager init done');
  }
  static Set<String> getKeys() {
    return CookieManager._prefs.getKeys();
  }
  static Future<bool> setString(key, value) async{
    return await CookieManager._prefs.setString(key, value);
  }
  static String getString(key){
    return CookieManager._prefs.get(key);
  }
  static Future<bool> clear() {
    return CookieManager._prefs.clear();
  }
}