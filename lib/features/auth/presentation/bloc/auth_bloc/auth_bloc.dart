import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todos/core/usecases/usecase.dart';
import 'package:flutter_todos/features/auth/domain/entities/app_user.dart';
import 'package:flutter_todos/features/auth/domain/usecases/cache_user.dart';
import 'package:flutter_todos/features/auth/domain/usecases/logout.dart';
import 'package:flutter_todos/features/auth/domain/usecases/reset_password.dart'
    as reset;

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CacheUser cacheUser;
  final Logout logout;
  final FirebaseAuth auth;
  final reset.ResetPassword resetPassword;
  AuthBloc({
    required this.cacheUser,
    required this.logout,
    required this.auth,
    required this.resetPassword,
  }) : super(
          auth.currentUser != null
              ? AuthState.loading(AppUser(uid: auth.currentUser!.uid))
              : const AuthState.unauthenticated(),
        ) {
    on<AppUserChanged>(_onUserChanged);
    on<AppLogoutRequested>(_onLogoutRequested);
    on<AppUserUpdated>(_onUserUpdated);
    on<PasswordResetRequested>(_resetPassword);
  }

  Future<void> _onUserChanged(
      AppUserChanged event, Emitter<AuthState> emit) async {}

  Future<void> _onLogoutRequested(
      AppLogoutRequested event, Emitter<AuthState> emit) async {}

  Future<void> _onUserUpdated(
      AppUserUpdated event, Emitter<AuthState> emit) async {}

  Future<void> _resetPassword(
      PasswordResetRequested event, Emitter<AuthState> emit) async {}
}
