import 'package:shared_preferences/shared_preferences.dart';

typedef SharedEdit = Function(SharedPreferences prefs);

extension SharedPreferenceExtension on SharedPreferences {
  String getStringSafelly(key) => containsKey(key) ? getString(key) : null;
  bool getBoolSafelly(key) => containsKey(key) ? getBool(key) : false;
}

class SharedPreferencesUtil {

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getStringSafelly(key);
  }

  static Future<bool> putString(String key, String value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(key, value);
  }

  static Future<bool> putBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setBool(key, value);
  }

  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getBoolSafelly(key);
  }

  static edit(SharedEdit edit) async {
    var prefs = await SharedPreferences.getInstance();
    edit(prefs);
  }

}
