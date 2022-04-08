part of 'auth_bloc.dart';

enum AuthStatus {
  loading,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  const AuthState._({
    required this.status,
    this.user = AppUser.empty,
  });

  const AuthState.authenticated(AppUser user)
      : this._(status: AuthStatus.authenticated, user: user);

  const AuthState.loading(AppUser user)
      : this._(status: AuthStatus.loading, user: user);

  const AuthState.unauthenticated()
      : this._(status: AuthStatus.unauthenticated);

  final AuthStatus status;
  final AppUser user;

  @override
  List<Object> get props => [status, user];
}
