import 'package:flutter_todos/core/cache/cache.dart';
import 'package:flutter_todos/features/auth/data/models/user_model.dart';
import 'package:flutter_todos/features/auth/domain/entities/user.dart';

abstract class AppUserLocalDataSource {
  /// Throws a [ServerException] for all error codes.
  bool checkIfUserExists();
  AppUser getUser();
  Future<bool> cacheUser(AppUserModel userModel);
}

class UserLocalDataSourceImpl implements AppUserLocalDataSource {
  @override
  bool checkIfUserExists() {
    return CacheClient.contains(APP_USER);
  }

  @override
  AppUser getUser() {
    return AppUserModel.fromJson(CacheClient.loadJson(APP_USER));
  }

  @override
  Future<bool> cacheUser(AppUserModel userModel) {
    return CacheClient.saveJson(APP_USER, userModel.toJson());
  }
}
