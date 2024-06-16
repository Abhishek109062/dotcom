
import 'package:dot_com/subadmin/theme/subadmin_pallet.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static _border({Color color = Colors.grey, double width = 2}) => OutlineInputBorder(
    borderSide: BorderSide(
      color: color,
      width: width,
    ),
    borderRadius: BorderRadius.circular(10),
  );
  static final lightThemeMode = ThemeData.light().copyWith(
    scaffoldBackgroundColor: SubAdminAppPallete.backgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: SubAdminAppPallete.backgroundColor,
    ),
    chipTheme: const ChipThemeData(
      color: MaterialStatePropertyAll(
        SubAdminAppPallete.backgroundColor,
      ),
      side: BorderSide.none,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(12),
      border: _border(width: 1),
      enabledBorder: _border(width: 1),
      focusedBorder: _border(color: SubAdminAppPallete.primaryColor),
      errorBorder: _border(color : SubAdminAppPallete.errorColor),
    ),
  );
}