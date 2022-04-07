import 'package:flutter/material.dart';
import 'package:flutter_todos/common/routes/route_names.dart';
import 'package:flutter_todos/features/auth/screens/login_screen.dart';
import 'package:flutter_todos/features/auth/screens/signup_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {

      /// Login Screen
      case RouteNames.loginScreen:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      /// Sign Up Screen
      case RouteNames.signUpScreen:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      /// Default route
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute<dynamic>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
