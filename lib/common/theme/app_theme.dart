import 'package:flutter/material.dart';
import 'package:flutter_todos/common/theme/color-scheme.dart';

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  useMaterial3: true,
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.surface,
  textTheme: TextTheme(
    displayLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 57,
        height: 1.12,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    displayMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 45,
        height: 1.16,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    displaySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 36,
        height: 1.22,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    headlineLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 32,
        height: 1.25,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    headlineMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 28,
        height: 1.29,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    headlineSmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 24,
        height: 1.33,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    titleLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 22,
        height: 1.27,
        letterSpacing: 0,
        color: darkColorScheme.onBackground),
    titleMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        color: darkColorScheme.onBackground),
    titleSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
        color: darkColorScheme.onBackground),
    labelLarge: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.1,
        color: darkColorScheme.onBackground),
    labelMedium: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.5,
        color: darkColorScheme.onBackground),
    labelSmall: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 11,
        height: 1.45,
        letterSpacing: 0.5,
        color: darkColorScheme.onBackground),
    bodyLarge: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16,
        height: 1.5,
        letterSpacing: 0.15,
        color: darkColorScheme.onBackground),
    bodyMedium: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 14,
        height: 1.43,
        letterSpacing: 0.25,
        color: darkColorScheme.onBackground),
    bodySmall: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 12,
        height: 1.33,
        letterSpacing: 0.4,
        color: darkColorScheme.onBackground),
  ),
  fontFamily: 'Poppins',
  appBarTheme: AppBarTheme(backgroundColor: darkColorScheme.primary),
  disabledColor: const Color.fromARGB(30, 31, 31, 31),
  primaryColor: darkColorScheme.primary,
  cardTheme: CardTheme(
    color: darkColorScheme.primaryContainer,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all(darkColorScheme.primaryContainer),
      foregroundColor:
          MaterialStateProperty.all(darkColorScheme.onPrimaryContainer),
      minimumSize: MaterialStateProperty.all(
        const Size(255, 59),
      ),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(darkColorScheme.onPrimary),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: darkColorScheme.primaryContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: darkColorScheme.secondary,
    selectedItemColor: darkColorScheme.primary,
    unselectedItemColor: darkColorScheme.onSecondary,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 0,
  ),
  primaryColorLight: darkColorScheme.primaryContainer,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: darkColorScheme.primary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: darkColorScheme.onPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: darkColorScheme.onPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
  ),
);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 1.12,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 1.16,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 1.22,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 1.25,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 1.29,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 1.33,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    titleLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 22,
      height: 1.27,
      letterSpacing: 0,
      color: lightColorScheme.onBackground,
    ),
    titleMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.15,
      color: lightColorScheme.onBackground,
    ),
    titleSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      color: lightColorScheme.onBackground,
    ),
    labelLarge: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.1,
      color: lightColorScheme.onBackground,
    ),
    labelMedium: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.5,
      color: lightColorScheme.onBackground,
    ),
    labelSmall: TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 1.45,
      letterSpacing: 0.5,
      color: lightColorScheme.onBackground,
    ),
    bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 1.5,
      letterSpacing: 0.15,
      color: lightColorScheme.onBackground,
    ),
    bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 1.43,
      letterSpacing: 0.25,
      color: lightColorScheme.onBackground,
    ),
    bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 1.33,
      letterSpacing: 0.4,
      color: lightColorScheme.onBackground,
    ),
  ),
  fontFamily: 'Poppins',
  disabledColor: const Color.fromARGB(30, 31, 31, 31),
  primaryColor: lightColorScheme.primary,
  cardTheme: CardTheme(
    color: lightColorScheme.primaryContainer,
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
      ),
      backgroundColor:
          MaterialStateProperty.all(lightColorScheme.primaryContainer),
      foregroundColor:
          MaterialStateProperty.all(lightColorScheme.onPrimaryContainer),
      minimumSize: MaterialStateProperty.all(
        const Size(255, 59),
      ),
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(100))),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor:
          MaterialStateProperty.all<Color>(lightColorScheme.onPrimary),
    ),
  ),
  dialogTheme: DialogTheme(
    backgroundColor: lightColorScheme.primaryContainer,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(28),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: lightColorScheme.secondary,
    selectedItemColor: lightColorScheme.primary,
    unselectedItemColor: lightColorScheme.onSecondary,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    type: BottomNavigationBarType.fixed,
    elevation: 4,
  ),
  primaryColorLight: lightColorScheme.primaryContainer,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: lightColorScheme.primary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: lightColorScheme.onPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: BorderSide(
        color: lightColorScheme.onPrimary,
        width: 1.0,
        style: BorderStyle.solid,
      ),
    ),
  ),
);
