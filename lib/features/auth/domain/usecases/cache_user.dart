import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/core/error/failures.dart';
import 'package:flutter_todos/core/usecases/usecase.dart';
import 'package:flutter_todos/features/auth/domain/entities/app_user.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';

class CacheUser implements UseCase<bool, Params> {
  final AppUserRepository repository;

  CacheUser(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.cacheUser(params.user);
  }
}

class Params extends Equatable {
  final AppUser user;

  Params({required this.user});

  @override
  List<Object> get props => [user];
}
