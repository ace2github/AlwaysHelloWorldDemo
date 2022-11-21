import 'package:flutter/widgets.dart';

class SZProviderNotifierCenter extends ChangeNotifier {
  SZProviderNotifierCenter._privateConstructor();
  static final SZProviderNotifierCenter shareInstance =
      SZProviderNotifierCenter._privateConstructor();

  // 变量的更新
  bool _changeLike = false;
  set changeLike(bool flag) {
    _changeLike = !_changeLike;
    notifyListeners();
    print("notify");
  }
}
