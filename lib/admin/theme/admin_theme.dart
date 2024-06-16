import 'package:flutter/material.dart';

import 'admin_pallet.dart';

class AdminAppTheme {
  static _border({Color color = Colors.grey, double width = 2}) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: AdminAppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AdminAppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        AdminAppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      border: _border(width: 1),
      enabledBorder: _border(width: 1),
      focusedBorder: _border(color: AdminAppPallete.primaryColor),
      errorBorder: _border(color : AdminAppPallete.errorColor),
    ),
  );
}