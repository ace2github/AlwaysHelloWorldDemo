import 'package:flutter/cupertino.dart';

class SZRouterObservers extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(this.navigator?.widget);
    // print(route.settings.name);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print(route);
  }
}
