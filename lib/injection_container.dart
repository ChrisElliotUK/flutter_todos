import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:guidemap/core/cache/shared_preferences_operator.dart';
import 'package:guidemap/features/auth/domain/usecases/check_if_user_exists.dart';
import 'package:guidemap/features/auth/domain/usecases/reset_password%20copy.dart';
import 'package:guidemap/features/settings/domain/usecases/register_user.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/grpc/server.dart';
import 'core/network/network_info.dart';
import 'core/remote_config/remote_config_defaults.dart';
import 'core/usecases/usecase.dart';
import 'core/util/env.dart';
import 'features/auth/data/datasources/user_local_data_source.dart';
import 'features/auth/data/datasources/app_user_remote_data_source.dart';
import 'features/auth/data/repositories/app_user_repository_impl.dart';
import 'features/auth/domain/repositories/app_user_repository.dart';
import 'features/auth/domain/usecases/delete_user.dart';
import 'features/auth/domain/usecases/get_app_user_stream.dart';
import 'features/auth/domain/usecases/is_logged_in.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register_with_email_and_password.dart';
import 'features/auth/domain/usecases/reset_password.dart';
import 'features/auth/domain/usecases/sign_in_with_apple.dart';
import 'features/auth/domain/usecases/sign_in_with_email.dart';
import 'features/auth/domain/usecases/sign_in_with_google.dart';
import 'features/auth/domain/usecases/verify_email.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';
import 'features/auth/presentation/bloc/login/login_cubit.dart';
import 'features/auth/presentation/bloc/reset_password/reset_password_cubit.dart';
import 'features/home/data/datasources/home_local_data_source.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/cms_load.dart';
import 'features/home/domain/usecases/initial_home_load.dart';
import 'features/home/domain/usecases/save_brightness_state.dart';
import 'features/home/domain/usecases/save_current_home_state.dart';
import 'features/home/domain/usecases/save_current_language_code.dart';
import 'features/home/domain/usecases/save_current_location.dart';
import 'features/home/domain/usecases/save_current_menu_state.dart';
import 'features/home/presentation/bloc/home/home_cubit.dart';
import 'features/map/presentation/bloc/map/map_bloc.dart';
import 'features/settings/data/datasources/settings_remote_data_source.dart';
import 'features/settings/data/repositories/settings_repository_impl.dart';
import 'features/settings/domain/repositories/settings_repository.dart';
import 'features/settings/domain/usecases/check_username.dart';
import 'features/settings/domain/usecases/finish_onboarding.dart';
import 'features/settings/domain/usecases/toggle_private_profile.dart';
import 'features/settings/domain/usecases/update_bio.dart';
import 'features/settings/domain/usecases/update_display_name.dart';
import 'features/settings/domain/usecases/update_display_picture.dart';
import 'features/settings/domain/usecases/update_dob.dart';
import 'features/settings/domain/usecases/update_username.dart';
import 'features/settings/domain/usecases/update_website.dart';
import 'features/settings/presentation/bloc/bio/bio_cubit.dart';
import 'features/settings/presentation/bloc/display_name/display_name_cubit.dart';
import 'features/settings/presentation/bloc/dob/dob_cubit.dart';
import 'features/settings/presentation/bloc/picture/picture_cubit.dart';
import 'features/settings/presentation/bloc/private_profile/private_profile_cubit.dart';
import 'features/settings/presentation/bloc/username/username_cubit.dart';
import 'features/settings/presentation/bloc/website/website_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => SharedPreferencesOperator(sl()));
  sl.registerLazySingleton(() => FirebaseDynamicLinks.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
  sl.registerLazySingleton(() => GoogleSignIn());
  sl.registerLazySingleton(() => FirebaseStorage.instance);
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => Location());
  sl.registerLazySingleton(() => FirebaseRemoteConfig.instance);
  await setUpRemoteConfigDefaults(sl());

  final server = Server(
    port: int.parse(getEnv(SERVER_PORT, defaultValue: DEFAULT_SERVER_PORT)),
    apiUrl: getEnv(SERVER_ADDRESS, defaultValue: DEFAULT_SERVER_ADDRESS),
    auth: sl(),
  );
  server.serverLogin();
  sl.registerLazySingleton(() => server);

  //! Feature - auth
  featureAuth();

  //! Feature - home
  await featureHome();

  //! Feature - settings
  featureSettings();

  //! Feature - Map
  featureMap();
}

void featureMap() {
  //! Feature - Map
  // Bloc

  sl.registerFactory(
    () => MapBloc(
      sl(),
    ),
  );
}

void featureAuth() {
  //! Feature - Start
  // Bloc

  sl.registerFactory(
    () => AuthBloc(
      remoteConfig: sl(),
      cacheUser: sl(),
      checkIfUserExists: sl(),
      resetPassword: sl(),
      getAppUser: sl(),
      logout: sl(),
      auth: sl(),
    ),
  );

  sl.registerFactory(
    () => LoginCubit(
      signInWithApple: sl(),
      signInWithEmail: sl(),
      signInWithGoogle: sl(),
      registerWithEmailAndPassword: sl(),
    ),
  );

  sl.registerFactory(
    () => ResetPasswordCubit(
      resetPassword: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => CacheUser(sl()));
  sl.registerLazySingleton(() => CheckIfUserExists(sl()));
  sl.registerLazySingleton(() => GetAppUserStream(sl()));
  sl.registerLazySingleton(() => Logout(sl()));
  sl.registerLazySingleton(() => RegisterWithEmailAndPassword(sl()));
  sl.registerLazySingleton(() => ResetPassword(sl()));
  sl.registerLazySingleton(() => SignInWithApple(sl()));
  sl.registerLazySingleton(() => SignInWithEmail(sl()));
  sl.registerLazySingleton(() => SignInWithGoogle(sl()));
  sl.registerLazySingleton(() => VeryifyEmail(sl()));
  sl.registerLazySingleton(() => IsLoggedIn(sl()));
  sl.registerLazySingleton(() => DeleteUser(sl()));

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

Future<void> featureHome() async {
  //! Feature - Home

  // Use cases
  sl.registerLazySingleton(() => SaveBrightnessState(sl()));
  sl.registerLazySingleton(() => SaveCurrentHomeState(sl()));
  sl.registerLazySingleton(() => SaveCurrentMenuState(sl()));
  sl.registerLazySingleton(() => InitialHomeLoad(sl()));
  sl.registerLazySingleton(() => SaveCurrentLanguageCode(sl()));
  sl.registerLazySingleton(() => CmsLoad(sl()));
  sl.registerLazySingleton(() => SaveCurrentLocation(sl()));

  // Repository
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<HomeLocalDataSource>(
    () => HomeLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(
      firebaseFirestore: sl(),
    ),
  );

  // Bloc
  final initialResult = await (sl<InitialHomeLoad>())(NoParams());
  final state = initialResult.fold(
    (failure) => HomeState.initial(),
    (success) => success,
  );

  sl.registerFactory(
    () => HomeCubit(
      usecaseCmsLoad: sl(),
      usecaseSaveCurrentLanguageCode: sl(),
      usecaseSaveBrightnessState: sl(),
      usecaseSaveCurrentHomeState: sl(),
      usecaseSaveCurrentMenuState: sl(),
      state: state,
      usecaseSaveCurrentLocation: sl(),
    ),
  );
}

void featureSettings() async {
  //! Feature - Settings

  // Use cases
  sl.registerLazySingleton(() => CheckUsername(sl()));
  sl.registerLazySingleton(() => FinishOnboarding(sl()));
  sl.registerLazySingleton(() => TogglePrivateProfile(sl()));
  sl.registerLazySingleton(() => UpdateWebsite(sl()));
  sl.registerLazySingleton(() => UpdateUsername(sl()));
  sl.registerLazySingleton(() => UpdateDob(sl()));
  sl.registerLazySingleton(() => UpdateDisplayPicture(sl()));
  sl.registerLazySingleton(() => UpdateDisplayName(sl()));
  sl.registerLazySingleton(() => UpdateBio(sl()));
  sl.registerLazySingleton(() => RegisterUser(sl()));

  // Repository
  sl.registerLazySingleton<SettingsRepository>(
    () => SettingsRepositoryImpl(
      remoteDataSource: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<SettingsRemoteDataSource>(
    () => SettingsRemoteDataSourceImpl(
      server: sl(),
      auth: sl(),
      storage: sl(),
    ),
  );

  // Bloc
  sl.registerFactory(
    () => PrivateProfileCubit(
      togglePrivateProfile: sl(),
    ),
  );

  sl.registerFactory(
    () => BioCubit(
      updateBio: sl(),
    ),
  );

  sl.registerFactory(
    () => DisplayNameCubit(
      updateDisplayName: sl(),
    ),
  );

  sl.registerFactory(
    () => DobCubit(
      updateDob: sl(),
    ),
  );
  sl.registerFactory(
    () => PictureCubit(
      finishOnboarding: sl(),
      updateDisplayPicture: sl(),
    ),
  );
  sl.registerFactory(
    () => UsernameCubit(
      registerUser: sl(),
      updateUsername: sl(),
      checkUsername: sl(),
    ),
  );
  sl.registerFactory(
    () => WebsiteCubit(
      updateWebsite: sl(),
    ),
  );
}
