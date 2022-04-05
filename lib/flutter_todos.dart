import 'package:flutter/material.dart';
import 'package:flutter_todos/common/theme/app_theme.dart';
import 'package:flutter_todos/features/auth/screens/auth_screen.dart';

class FlutterTodos extends StatelessWidget {
  const FlutterTodos({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: darkTheme,
      theme: lightTheme,
      home: const AuthScreen(),
    );
  }
}
