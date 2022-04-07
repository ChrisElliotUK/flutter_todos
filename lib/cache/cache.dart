import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

/// A class that provides access to the shared preferences.
class Cache {
  /// The shared preferences instance.
  static Future<SharedPreferences> getInstance() async {
    return SharedPreferences.getInstance();
  }

  /// save a [String] value to the shared preferences.
  static Future<bool> setString(
      {required String key, required String value}) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setString(key, value);
  }

  /// Get a [String] value from the shared preferences.
  static Future<String?> getString({required String key}) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.getString(key);
  }

  /// Save a [int] value to the shared preferences.
  static Future<bool> setInt(String key, int value) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setInt(key, value);
  }

  /// Get a [int] value from the shared preferences.
  static Future<int?> getInt(String key) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.getInt(key);
  }

  /// Save a [bool] value to the shared preferences.
  static Future<bool> setBool(String key, bool value) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setBool(key, value);
  }

  /// Get a [bool] value from the shared preferences.
  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.getBool(key);
  }

  /// Save a [double] value to the shared preferences.
  static Future<bool> setDouble(String key, double value) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setDouble(key, value);
  }

  /// Get a [double] value from the shared preferences.
  static Future<double?> getDouble(String key) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.getDouble(key);
  }

  /// Save a [List<String>] value to the shared preferences.
  static Future<bool> setStringList(
      {required String key, required List<String> value}) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setStringList(key, value);
  }

  /// Get a [List<String>] value from the shared preferences.
  static Future<List<String>?> getStringList(String key) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.getStringList(key);
  }

  /// Remove an entry from the shared preferences.
  static Future<bool> remove(String key) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.remove(key);
  }

  /// Store a model as json in the cache
  static Future<dynamic> getJson({required String key}) async {
    final SharedPreferences prefs = await getInstance();
    return json.decode(prefs.getString(key)!);
  }

  /// Get a model as json from the cache
  static Future<bool> setJson(
      {required String key, required dynamic value}) async {
    final SharedPreferences prefs = await getInstance();
    return prefs.setString(key, json.encode(value));
  }
}

/// {@template cache_client}
/// An in-memory cache client.
/// {@endtemplate}
class CacheClient {
  /// {@macro cache_client}
  CacheClient() : _cache = <String, Object>{};

  final Map<String, Object> _cache;

  /// Writes the provide [key], [value] pair to the in-memory cache.
  void write<T extends Object>({required String key, required T value}) {
    _cache[key] = value;
  }

  /// Looks up the value for the provided [key].
  /// Defaults to `null` if no value exists for the provided key.
  T? read<T extends Object>({required String key}) {
    final value = _cache[key];
    if (value is T) return value;
    return null;
  }
}
