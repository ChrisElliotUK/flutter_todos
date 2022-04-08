import 'package:dartz/dartz.dart';

import 'package:flutter_todos/features/auth/data/datasources/user_local_data_source.dart';
import 'package:flutter_todos/features/auth/data/models/user_model.dart';
import 'package:flutter_todos/features/auth/domain/errors/auth_errors.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/app_user.dart';
import '../datasources/app_user_remote_data_source.dart';

class AppUserRepositoryImpl implements AppUserRepository {
  final AppUserRemoteDataSource remoteDataSource;
  final AppUserLocalDataSource localDataSource;

  AppUserRepositoryImpl(
      {required this.localDataSource, required this.remoteDataSource, s});

  @override
  Future<Either<Failure, bool>> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      final user =
          await remoteDataSource.registerWithEmailAndPassword(email, password);
      return Right(user);
    } on SignUpWithEmailAndPasswordFailure catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword(String email) async {
    try {
      final success = await remoteDataSource.resetPassword(email);
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signInWithApple() async {
    try {
      final success = await remoteDataSource.signInWithApple();
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signInWithEmail(
      String email, String password) async {
    try {
      final success = await remoteDataSource.signInWithEmail(email, password);
      return Right(success);
    } on LogInWithEmailAndPasswordFailure catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> signInWithGoogle() async {
    try {
      final success = await remoteDataSource.signInWithGoogle();
      return Right(success);
    } on LogInWithGoogleFailure catch (e) {
      return Left(AuthFailure(errorMessage: e.message));
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(String email) async {
    try {
      final success = await remoteDataSource.signInWithGoogle();
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      final success = await remoteDataSource.logout();
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> deleteUser() async {
    try {
      final success = await remoteDataSource.deleteUser();
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> isLoggedIn() async {
    try {
      final success = await remoteDataSource.isLoggedIn();
      return Right(success);
    } catch (_) {
      return Left(AuthFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> cacheUser(AppUser user) async {
    try {
      localDataSource.cacheUser(user as AppUserModel);
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(errorMessage: e.toString()));
    }
  }
}
