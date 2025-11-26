import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static late SharedPreferences sharedpref;

  static Future<SharedPreferences> init() async {
    sharedpref = await SharedPreferences.getInstance();
    return sharedpref;
  }

  static Future<bool> saveData(
      {required String key, required dynamic value}) async {
    if (value is int) {
      return await sharedpref.setInt(key, value);
    } else if (value is double) {
      return await sharedpref.setDouble(key, value);
    } else if (value is bool) {
      return await sharedpref.setBool(key, value);
    } else if (value is String) {
      return await sharedpref.setString(key, value);
    } else {
      return await sharedpref.setStringList(key, value);
    }
  }

  static Object? getData({required String key}) {
    return sharedpref.get(key);
  }

  static Future<bool> removeData({required String key}) async {
    return await sharedpref.remove(key);
  }
}
