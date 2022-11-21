import 'package:flutter/material.dart';

class AppThemes {
  /* 
  1、设置公用的样式
  */
  static const double _titleFontSize = 20;

  // 2.亮色主题
  static final ThemeData lightTheme = ThemeData(
      primarySwatch: Colors.pink,
      primaryTextTheme: TextTheme(
          headline1: TextStyle(color: Colors.yellow, fontSize: _titleFontSize)),
      textTheme: TextTheme(bodyMedium: TextStyle(color: Colors.red)));

  // 3.暗黑主题
  static final ThemeData darkTheme = ThemeData(
      primaryColor: Colors.grey,
      primaryTextTheme: TextTheme(
          headline1: TextStyle(color: Colors.white, fontSize: _titleFontSize)),
      textTheme: TextTheme(
          headline1: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70)));
}
