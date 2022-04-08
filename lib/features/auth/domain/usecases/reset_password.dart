import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/core/error/failures.dart';
import 'package:flutter_todos/core/usecases/usecase.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';

class ResetPassword implements UseCase<bool, Params> {
  final AppUserRepository repository;

  ResetPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.resetPassword(params.email);
  }
}

class Params extends Equatable {
  final String email;

  Params({required this.email});

  @override
  List<Object> get props => [email];
}
