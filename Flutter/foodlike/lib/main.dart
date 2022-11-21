import 'package:flutter/material.dart';
import 'package:foodlike/routers/SZRouterObserver.dart';
import 'package:foodlike/routers/SZRouters.dart';
import 'package:foodlike/themes/SZAppThemes.dart';
import 'package:foodlike/themes/SZDeviceInfo.dart';
import 'package:provider/provider.dart';

import 'model/SZProviderManager.dart';

void main() {
  runApp(ChangeNotifierProvider(
    child: const MyApp(),
    create: (context) {
      return SZProviderNotifierCenter.shareInstance;
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SZDeviceInfo.initialize();

    return MaterialApp(
      title: '我爱未来',
      theme: SZAppThemes.normalTheme,
      darkTheme: SZAppThemes.darkTheme,
      navigatorObservers: [SZRouterObservers()],
      initialRoute: SZRouters.initailRoute,
      routes: SZRouters.routers,
      onGenerateRoute: SZRouters.generateRoute,
      onUnknownRoute: SZRouters.unknownRoute,
    );
  }
}
