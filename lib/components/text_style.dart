import 'dart:ui';

import 'package:flutter/material.dart';

class Text_Style {
  static TextStyle small({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
        fontSize: 14,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle medium({Color? color, FontWeight? fontWeight}) {
    return TextStyle(
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
        fontSize: 16,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle big({Color? color, FontWeight? fontWeight, double? fontSize}) {
    return TextStyle(
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.w400);
  }

  static TextStyle large(
      {Color? color, FontWeight? fontWeight, TextOverflow? overflow}) {
    return TextStyle(
        fontFamily: 'Poppins',
        color: color ?? Colors.black,
        overflow: overflow ?? null,
        fontSize: 20,
        fontWeight: fontWeight ?? FontWeight.w600);
  }
}
