import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager<T> {
  late String _key;

  SharedPreferencesManager(String key) {
    _key = key;
  }

  Future<void> saveData(T data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String jsonData = jsonEncode(data);
    prefs.setString(_key, jsonData);
  }

  Future<T?> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString(_key);
    if (storedData != null) {
      return jsonDecode(storedData) as T;
    } else {
      return null;
    }
  }

  Future<bool> removeData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(_key);
  }

  Future<void> saveSecureData(T data) async {
    const storage = FlutterSecureStorage();
    String jsonData = jsonEncode(data);
    await storage.write(key: _key, value: jsonData);
  }

  Future<T?> getSecureData() async {
    const storage = FlutterSecureStorage();
    String? storedData = await storage.read(key: _key);
    if (storedData != null) {
      return jsonDecode(storedData) as T;
    } else {
      return null;
    }
  }

  Future<bool> removeSecureData() async {
    try {
      const storage = FlutterSecureStorage();
      await storage.delete(key: _key);
      return true;
    } catch (e) {
      print('Error removing secure data: $e');
      return false;
    }
  }
}
