import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Light {
  static const Color primaryColor = Colors.black;
  static const Color primaryVariantColor = Colors.red;
  static const Color backgroundColor = Colors.white;
  static const Color onPrimaryColor = Colors.white;
  static const Color textColorPrimary = Colors.black;
  static const Color appbarColor = Colors.white;
  static const Color appbarForegroundColor = Colors.black;
  static const Color accentColor = Color(0xFF10b981);

  static const TextTheme textTheme = Typography.blackCupertino;

  Light._();
}

class Dark {
  static final Color primaryColor = Colors.blueGrey.shade900;
  static const Color primaryVariantColor = Colors.black;
  static const Color backgroundColor = Colors.black87;
  static final Color onPrimaryColor = Colors.blueGrey.shade300;
  static const Color textColorPrimary = Colors.white;
  static final Color appbarColor = Colors.blueGrey.shade800;
  static const Color appbarForegroundColor = Colors.white;
  static const Color accentColor = Color.fromRGBO(74, 217, 217, 1);

  static const TextTheme textTheme = Typography.blackCupertino;

  Dark._();
}

class AppTheme {
  AppTheme._();

  static const Color iconColor = Colors.black;

  static final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
    ),
    splashFactory: NoSplash.splashFactory,
  );

  static final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
    ),
    splashFactory: NoSplash.splashFactory,
  );

  static final ButtonStyle outlineButtonStyle = OutlinedButton.styleFrom(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.elliptical(5, 5)),
    ),
    splashFactory: NoSplash.splashFactory,
  );

  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    floatingLabelStyle: const TextStyle(color: Colors.black),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Colors.black)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  );

  static final ThemeData lightTheme = ThemeData(
    inputDecorationTheme: inputDecorationTheme,
    scaffoldBackgroundColor: Light.backgroundColor,
    appBarTheme: const AppBarTheme(
      color: Light.appbarColor,
      foregroundColor: Light.appbarForegroundColor,
      iconTheme: IconThemeData(color: iconColor),
      elevation: 0,
    ),
    colorScheme: const ColorScheme.light(
      primary: Light.primaryColor,
      onPrimary: Light.onPrimaryColor,
      secondary: Light.accentColor,
      background: Light.backgroundColor,
    ),
    textTheme: Light.textTheme,
    bottomAppBarTheme: const BottomAppBarTheme(color: Light.appbarColor),
    textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
  );

  static final ThemeData darkTheme = ThemeData(
    inputDecorationTheme: inputDecorationTheme,
    scaffoldBackgroundColor: Dark.backgroundColor,
    appBarTheme: AppBarTheme(
        color: Dark.appbarColor,
        foregroundColor: Dark.appbarForegroundColor,
        iconTheme: const IconThemeData(color: iconColor)),
    colorScheme: ColorScheme.dark(
      primary: Dark.primaryColor,
      onPrimary: Dark.onPrimaryColor,
      secondary: Dark.accentColor,
      background: Dark.backgroundColor,
    ),
    textTheme: Dark.textTheme,
    bottomAppBarTheme: BottomAppBarTheme(color: Dark.appbarColor),
    textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
  );
}
