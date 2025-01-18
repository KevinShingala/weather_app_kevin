import 'package:shared_preferences/shared_preferences.dart';

class AppPrefs {
  static final AppPrefs _appPreference = AppPrefs._internal();

  factory AppPrefs() {
    return _appPreference;
  }

  AppPrefs._internal();

  late SharedPreferences _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  Future setString(String key, String value) async {
    await _preferences.setString(key, value);
  }

  String getString(String key, {String defValue = ''}) {
    return _preferences.getString(key) != null
        ? (_preferences.getString(key) ?? '')
        : defValue;
  }

  Future setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  bool getBool(String key, {bool defValue = false}) {
    return _preferences.getBool(key) ?? defValue;
  }

  bool? getBoolOrNull(String key) {
    return _preferences.getBool(key);
  }

  bool? getNullBool(String key, {bool defValue = false}) {
    return _preferences.getBool(key);
  }

  Future setInt(String key, int value) async {
    await _preferences.setInt(key, value);
  }

  int getInt(String key, {int defValue = 0}) {
    return _preferences.getInt(key) ?? defValue;
  }

  Future setStringList(String key, List<String> value) async {
    await _preferences.setStringList(key, value);
  }

  List<String> getStringList(String key, {List<String> defValue = const []}) {
    return _preferences.getStringList(key) ?? defValue;
  }

  Future clearSharedPreferences() async {
    await _preferences.clear();
  }

  Future removeValue(String key) async {
    await _preferences.remove(key);
  }
}
