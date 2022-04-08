import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_todos/core/cache/shared_preferences_operator.dart';
import 'package:flutter_todos/features/auth/domain/repository/app_user_repository.dart';
import 'package:flutter_todos/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/usecases/usecase.dart';
import 'features/auth/data/datasources/user_local_data_source.dart';
import 'features/auth/data/datasources/app_user_remote_data_source.dart';
import 'features/auth/domain/usecases/is_logged_in.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/reset_password.dart';
import 'features/auth/domain/usecases/sign_in_with_apple.dart';
import 'features/auth/domain/usecases/sign_in_with_email.dart';
import 'features/auth/domain/usecases/sign_in_with_google.dart';
import 'features/auth/domain/usecases/verify_email.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  // sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => SharedPreferencesOperator(sl()));
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => Connectivity());
  // await setUpRemoteConfigDefaults(sl());

  //! Feature - auth
  featureAuth();
}

void featureAuth() {
  //! Feature - Start
  // Bloc

  sl.registerFactory(
    () => AuthBloc(
      cacheUser: sl(),
      resetPassword: sl(),
      logout: sl(),
      auth: sl(),
    ),
  );

  // Use cases

  sl.registerLazySingleton(() => Logout(sl()));

  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => SignInWithApple(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => VeryifyEmail(sl()));
  sl.registerLazySingleton(() => IsLoggedIn(sl()));

  // Repository
  sl.registerLazySingleton<AppUserRepository>(
    () => AppUserRepositoryImpl(
      localDataSource: sl(),
      networkInfo: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<AppUserRemoteDataSource>(
    () => AppUserRemoteDataSourceImpl(
      localDataSource: sl(),
      auth: sl(),
      firestore: sl(),
      googleSignIn: sl(),
    ),
  );
  sl.registerLazySingleton<AppUserLocalDataSource>(
    () => AppUserLocalDataSourceImpl(),
  );
}
