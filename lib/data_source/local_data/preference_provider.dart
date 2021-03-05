import 'package:structure_example/data_source/local_data/preference_name.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceProvider {
  static SharedPreferences _prefs;
  static Map<String, dynamic> _memoryPrefs = Map<String, dynamic>();

  static Future<SharedPreferences> load() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs;
  }

  static Future setString(String key, String value) async {
    await load();
    await _prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setInt(String key, int value) async {
    await load();
    await _prefs.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setDouble(String key, double value) async {
    await load();
    await _prefs.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static Future setBool(String key, bool value) async {
    await load();
    await _prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static Future<String> getString(String key, {String def}) async {
    await load();
    String val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }

    if (val == null) {
      val = _prefs.getString(key);
    }
    if (val == null) {
      val = def;
    }

    _memoryPrefs[key] = val;
    return val;
  }

  static Future<int> getInt(String key, {int def}) async {
    await load();
    int val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getInt(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static Future<double> getDouble(String key, {double def}) async {
    await load();
    double val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getDouble(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static Future<bool> getBool(String key, {bool def = false}) async {
    await load();
    bool val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    if (val == null) {
      val = _prefs.getBool(key);
    }
    if (val == null) {
      val = def;
    }
    _memoryPrefs[key] = val;
    return val;
  }

  static Future<String> getToken() async => await getString(PreferenceNames.TOKEN);
  static Future<String> getFCMToken() async => await getString(PreferenceNames.FCM_TOKEN);

  static Future removeAll() async {
    await load();
    await _prefs.clear();
    _memoryPrefs.clear();
  }

  static Future remove(String key) async {
    await load();
    await _prefs.remove(key);
  }
}
