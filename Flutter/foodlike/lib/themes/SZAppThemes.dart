import 'package:flutter/material.dart';

class SZAppThemes {
  static const double fontNormal = 20;
  static const double fontSmall = 16;
  static const double fontLarge = 28;

  // 2、普通模式
  static final Color colorMainNormal = Colors.blue;
  static final ThemeData normalTheme = ThemeData(
    primarySwatch: Colors.pink,
    canvasColor: Colors.white, // 设置page背景色
    textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: fontNormal, color: colorMainNormal)),
  );

  static final Color colorMainDark = Colors.grey;
  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.pink,
    canvasColor: Color.fromARGB(255, 254, 222, 1),
    textTheme: TextTheme(
        bodyText1: TextStyle(fontSize: fontNormal, color: colorMainDark)),
  );
}
