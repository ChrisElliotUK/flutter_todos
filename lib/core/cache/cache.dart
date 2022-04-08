import 'dart:convert';

import 'package:flutter_todos/core/cache/shared_preferences_operator.dart';
import '../../injection_container.dart' as di;

export 'cache_values.dart';

abstract class CacheClient {
  /// Get a JSON value from the shared preferences.
  /// [key] is the key of the value to get.
  /// [defaultValue] is the value to return if the key is not found.
  /// Returns the value for the given key or the default value if the key is not found.
  static Map<String, dynamic> loadJson(String key,
      {Map<String, dynamic>? defaultValue}) {
    String? value =
        di.sl<SharedPreferencesOperator>().get(key, json.encode(defaultValue));
    return value != null ? json.decode(value) : defaultValue;
  }

  /// Set a JSON value in the shared preferences.
  /// [key] is the key for the value.
  /// [value] is the value to set.
  /// Returns true if the value was set.
  static Future<bool> saveJson(String key, Map<String, dynamic> value) {
    return di.sl<SharedPreferencesOperator>().set(key, json.encode(value));
  }

  /// Remove a value from the shared preferences.
  /// [key] is the key for the value.
  /// Returns true if the value was removed.
  static Future<bool> remove(String key) {
    return di.sl<SharedPreferencesOperator>().remove(key);
  }

  /// Clear all values from the shared preferences.
  /// Returns true if the shared preferences were cleared.
  static Future<bool> clear() {
    return di.sl<SharedPreferencesOperator>().clear();
  }

  /// Check if Shared Preferences contains a value for the given key.
  /// [key] is the key for the value.
  /// Returns true if the key is found.
  static bool contains(String key) {
    return di.sl<SharedPreferencesOperator>().contains(key);
  }

  /// Set a value in the shared preferences.
  /// [key] is the key for the value.
  /// [value] is the value to set.
  /// [T] is the type of the value.
  /// [T] must be a supported type.
  /// Supported types are: bool, int, double, String, List<String>, and Map<String, dynamic>.
  /// If the value is not one of the supported types, the value will be ignored.
  /// If the value is null, the key will be removed from the shared preferences.
  /// If the value is not null, the key will be set to the value.
  /// Returns true if the value was set.
  static Future<bool> save<T>(String key, T value) {
    return di.sl<SharedPreferencesOperator>().set(key, value);
  }

  /// Get a value from the shared preferences.
  /// [key] is the key for the value.
  /// [defaultValue] is the value to return if the key is not found.
  /// [T] is the type of the value.
  /// [T] must be a supported type.
  /// Supported types are: bool, int, double, String, List<String>, and Map<String, dynamic>.
  /// If the value is not one of the supported types, the default value will be returned.
  /// Returns the value for the given key or the default value if the key is not found.
  /// If the value is not one of the supported types, the default value will be returned.
  static T? load<T>(String key, T? defaultValue) {
    return di.sl<SharedPreferencesOperator>().get(key, defaultValue);
  }
}
