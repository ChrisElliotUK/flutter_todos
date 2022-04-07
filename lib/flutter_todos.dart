import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_todos/common/theme/app_theme.dart';
import 'package:flutter_todos/features/auth/bloc/auth_bloc/auth_bloc.dart';
import 'package:flutter_todos/features/auth/repository/auth_repository.dart';
import 'package:flutter_todos/features/auth/screens/auth_screen.dart';

class FlutterTodos extends StatelessWidget {
  const FlutterTodos({
    Key? key,
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(key: key);

  final AuthenticationRepository _authenticationRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) =>
            AuthBloc(authenticationRepository: _authenticationRepository),
        child: MaterialApp(
          title: 'Flutter Todos',
          darkTheme: darkTheme,
          theme: lightTheme,
          home: const AuthScreen(),
        ),
      ),
    );
  }
}
