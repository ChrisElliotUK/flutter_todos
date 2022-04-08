import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

import '../entities/app_user.dart';

abstract class AppUserRepository {
  Future<Either<Failure, bool>> cacheUser(AppUser user);
  Future<Either<Failure, bool>> signInWithEmail(String email, String password);
  Future<Either<Failure, bool>> signInWithGoogle();
  Future<Either<Failure, bool>> signInWithApple();
  Future<Either<Failure, bool>> logout();
  Future<Either<Failure, bool>> registerWithEmailAndPassword(
      String email, String password);
  Future<Either<Failure, bool>> verifyEmail(String email);
  Future<Either<Failure, bool>> resetPassword(String email);
  Future<Either<Failure, bool>> isLoggedIn();
  Future<Either<Failure, bool>> deleteUser();
}
