import 'package:dartz/dartz.dart';
import 'package:flutter_todos/core/error/failures.dart';
import 'package:flutter_todos/core/usecases/usecase.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';

class IsLoggedIn implements UseCase<bool, NoParams> {
  final AppUserRepository repository;

  IsLoggedIn(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.isLoggedIn();
  }
}
