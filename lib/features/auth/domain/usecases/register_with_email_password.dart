import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_todos/core/error/failures.dart';
import 'package:flutter_todos/core/usecases/usecase.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';

class RegisterWithEmailAndPassword implements UseCase<bool, Params> {
  final AppUserRepository repository;

  RegisterWithEmailAndPassword(this.repository);

  @override
  Future<Either<Failure, bool>> call(Params params) async {
    return await repository.registerWithEmailAndPassword(
        params.email, params.password);
  }
}

class Params extends Equatable {
  final String email;
  final String password;

  Params({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
