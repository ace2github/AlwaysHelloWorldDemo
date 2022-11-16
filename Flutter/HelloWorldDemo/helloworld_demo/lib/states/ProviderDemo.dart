import 'package:flutter/cupertino.dart';

class CustormProvider extends ChangeNotifier {
  int _counts = 199;
  int get timerCount => _counts;
  set timerCount(int val) {
    _counts = val;

    // 通知所有的监听者
    notifyListeners();
  }
}
