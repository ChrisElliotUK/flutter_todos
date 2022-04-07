import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_todos/features/auth/repository/auth_repository.dart';
import 'package:flutter_todos/flutter_todos.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final autenticationRepository = AuthenticationRepository();
  await autenticationRepository.user.first;
  runApp(FlutterTodos(
    authenticationRepository: autenticationRepository,
  ));
}
