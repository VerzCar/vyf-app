import 'package:flutter/material.dart';

class Light {
  static const Color primaryColor = Color(0xFF28282d);
  static const Color onPrimaryColor = Color(0xFFffffff);
  static const Color secondaryColor = Color(0xFF2962ff);
  static const Color onSecondaryColor = Color(0xFFFAFAFA);
  static const Color surfaceColor = Color(0xFFFAFAFA);
  static const Color onSurfaceColor = Color(0xFF0F0F0F);
  static const Color backgroundColor = Color(0xFFFAFAFA);
  static const Color successColor = Color(0xFF4caf50);
  static const Color warningColor = Color(0xFFFFA726);
  static const Color errorColor = Color(0xFFF44336);
  static const Color textColorPrimary = Colors.black;
  static const Color appbarColor = Colors.white;
  static const Color appbarForegroundColor = Colors.black;
  static const Color cardColor = Colors.white;
  static const Color white = Colors.white;

  static TextTheme textTheme = Typography.blackCupertino.apply(
    bodyColor: Colors.black,
    displayColor: Colors.black,
  );

  Light._();
}

class Dark {
  static const Color primaryColor = Colors.white70;
  static const Color onPrimaryColor = Colors.white10;
  static const Color secondaryColor = Color(0xff052b93);
  static const Color onSecondaryColor = Color(0xFFE7E7E7);
  static const Color surfaceColor = Color(0xFF0C0C0C);
  static const Color onSurfaceColor = Color(0xFFE5E5E5);
  static const Color backgroundColor = Colors.black87;
  static const Color successColor = Color(0xff3d8d40);
  static const Color warningColor = Color(0xFFE19521);
  static const Color errorColor = Color(0xFFC5352B);
  static const Color textColorPrimary = Colors.white;
  static const Color appbarColor = Color(0xFF212121);
  static const Color appbarForegroundColor = Colors.white;
  static const Color cardColor = Color(0xFF494949);
  static const Color white = Colors.white;

  static TextTheme textTheme = Typography.blackCupertino.apply(
    bodyColor: Colors.white,
    displayColor: Colors.white,
  );

  Dark._();
}

extension ColorSchemeExtension on ColorScheme {
  Color get successColor =>
      brightness == Brightness.light ? Light.successColor : Dark.successColor;

  Color get warningColor =>
      brightness == Brightness.light ? Light.warningColor : Dark.warningColor;
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
        borderRadius: BorderRadius.circular(8)),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
  );

  static ThemeData lightTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      splashFactory: NoSplash.splashFactory,
      inputDecorationTheme: inputDecorationTheme,
      iconTheme: const IconThemeData(color: Light.primaryColor),
      appBarTheme: const AppBarTheme(
        color: Light.appbarColor,
        foregroundColor: Light.appbarForegroundColor,
        iconTheme: IconThemeData(color: Light.primaryColor),
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Light.primaryColor,
        brightness: brightness,
        primary: Light.primaryColor,
        onPrimary: Light.onPrimaryColor,
        secondary: Light.secondaryColor,
        onSecondary: Light.onSecondaryColor,
        surface: Light.surfaceColor,
        onSurface: Light.onSurfaceColor,
        background: Light.backgroundColor,
        error: Light.errorColor,
      ),
      textTheme: Light.textTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Light.appbarColor,
        elevation: 4.0,
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.black45,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Light.appbarColor,
        elevation: 4.0,
      ),
      textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
      cardTheme: const CardTheme(
        color: Light.cardColor,
        surfaceTintColor: Light.cardColor,
        elevation: 2,
      ),
    );
  }

  static ThemeData darkTheme(Brightness brightness) {
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      splashFactory: NoSplash.splashFactory,
      inputDecorationTheme: inputDecorationTheme,
      iconTheme: const IconThemeData(color: Dark.primaryColor),
      appBarTheme: const AppBarTheme(
        color: Dark.appbarColor,
        foregroundColor: Dark.appbarForegroundColor,
        iconTheme: IconThemeData(color: Dark.primaryColor),
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSeed(
        seedColor: Dark.primaryColor,
        brightness: brightness,
        primary: Dark.primaryColor,
        onPrimary: Dark.onPrimaryColor,
        secondary: Dark.secondaryColor,
        onSecondary: Dark.onSecondaryColor,
        surface: Dark.surfaceColor,
        onSurface: Dark.onSurfaceColor,
        background: Dark.backgroundColor,
        error: Dark.errorColor,
      ),
      textTheme: Dark.textTheme,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Dark.appbarColor,
        elevation: 4.0,
        selectedItemColor: Colors.white70,
        unselectedItemColor: Colors.white54,
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Dark.appbarColor,
        elevation: 4.0,
      ),
      textButtonTheme: TextButtonThemeData(style: flatButtonStyle),
      elevatedButtonTheme: ElevatedButtonThemeData(style: raisedButtonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(style: outlineButtonStyle),
      cardTheme: const CardTheme(
        color: Dark.cardColor,
        surfaceTintColor: Dark.cardColor,
        elevation: 2,
      ),
    );
  }
}
