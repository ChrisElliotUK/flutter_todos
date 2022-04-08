part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AppLogoutRequested extends AuthEvent {}

class PasswordResetRequested extends AuthEvent {}

class AppUserUpdated extends AuthEvent {
  const AppUserUpdated(this.user);

  final AppUser user;

  @override
  List<Object?> get props => [user];
}

class AppUserChanged extends AuthEvent {
  const AppUserChanged(this.user);

  final User? user;

  @override
  List<Object?> get props => [user];
}
