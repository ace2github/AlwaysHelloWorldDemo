import 'package:flutter/material.dart';
import 'package:foodlike/pages/favorite/SZFavoritePage.dart';
import 'package:foodlike/pages/home/SZHomePage.dart';
import 'package:foodlike/pages/mine/SZMinePage.dart';
import 'package:foodlike/pages/home/SZDetailPage.dart';
import 'package:foodlike/pages/home/SZFoodList.dart';
import 'package:foodlike/pages/main/SZMainPage.dart';
import 'package:foodlike/pages/mine/SZSettingPage.dart';

import '../pages/home/SZFilterPage.dart';
import '../pages/mine/SZMinePage.dart';
import '../pages/unknown/SZNotFoundPage.dart';

class SZRouters {
  static final Map<String, WidgetBuilder> routers = {
    SZMainPage.routeName: (context) => SZMainPage(),
    SZFoodListPage.routeName: (context) => SZFoodListPage(),
    SZDetailPage.routeName: (context) => SZDetailPage(),
    SZHomePage.routeName: (context) => SZHomePage(),
    SZMinePage.routeName: (context) => SZMinePage(),
    SZSettingPage.routeName: (context) => SZSettingPage(),
    SZFavoritePage.routeName: (context) => SZFavoritePage(),
  };

  // 初始化的route
  static final String initailRoute = SZMainPage.routeName;

// 路由拦截
  static final RouteFactory generateRoute = (settings) {
    if (settings.name == SZFilterPage.routeName) {
      print("SZFilterPage.routeName");
      // 模态弹出
      return MaterialPageRoute(
          builder: (context) {
            return const SZFilterPage();
          },
          fullscreenDialog: true);
    }
    return null;
  };

  // 错误路由，可以提供统一的错误页面
  static final RouteFactory unknownRoute = (settings) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) {
        return SZNotFoundPage();
      },
    );
  };
}
