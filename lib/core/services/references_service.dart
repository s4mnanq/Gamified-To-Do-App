import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReferencesService extends GetxService {
  final _prefs = SharedPreferences.getInstance();

  Future<T?> getReference<T>(String key) async {
    final prefs = await _prefs;
    return prefs.get(key) as T?;
  }

  Future<String> getStringReference(String key) async {
    final prefs = await _prefs;
    return prefs.getString(key) ?? '';
  }

  Future<int?> getIntReference(String key) async {
    final prefs = await _prefs;
    return prefs.getInt(key);
  }

  Future<bool?> getBoolReference(String key) async {
    final prefs = await _prefs;
    return prefs.getBool(key);
  }

  Future<double?> getDoubleReference(String key) async {
    final prefs = await _prefs;
    return prefs.getDouble(key);
  }

  Future<void> setReference<T>(String key, T value) async {
    final prefs = await _prefs;
    if (value is int) {
      await prefs.setInt(key, value);
    } else if (value is double) {
      await prefs.setDouble(key, value);
    } else if (value is bool) {
      await prefs.setBool(key, value);
    } else if (value is String) {
      await prefs.setString(key, value);
    } else if (value is List<String>) {
      await prefs.setStringList(key, value);
    } else {
      throw UnsupportedError('Type not supported');
    }
  }
}
