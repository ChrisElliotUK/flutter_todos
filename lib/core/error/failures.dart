import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? errorMessage;

  Failure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class AppFailure extends Failure {
  final String? errorMessage;

  AppFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

// General failures
class ServerFailure extends Failure {
  final String? errorMessage;

  ServerFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {
  final String? errorMessage;

  CacheFailure({this.errorMessage});
  @override
  List<Object?> get props => [errorMessage];
}
