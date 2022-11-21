import 'package:flutter/material.dart';
import 'package:foodlike/pages/favorite/SZFavoritePage.dart';
import 'package:foodlike/pages/home/SZHomePage.dart';
import 'package:foodlike/pages/mine/SZMinePage.dart';

// pages
final List<Widget> tabPages = [SZHomePage(), SZFavoritePage(), SZMinePage()];

// items
final List<BottomNavigationBarItem> tabItems = [
  BottomNavigationBarItem(label: "首页", icon: Icon(Icons.home)),
  BottomNavigationBarItem(label: "收藏", icon: Icon(Icons.favorite)),
  BottomNavigationBarItem(label: "设置", icon: Icon(Icons.settings))
];
