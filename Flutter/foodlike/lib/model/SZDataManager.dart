import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:foodlike/model/SZHomeModule.dart';

class SZDataManager {
  static Future<List<SZHomeModule>> loadHomeModule() async {
    final String homeModuleStr =
        await rootBundle.loadString("assets/json/category.json");
    var homeModule = json.decode(homeModuleStr);
    final moduleList = homeModule["category"];

    List<SZHomeModule> totalList = [];
    for (var el in moduleList) {
      SZHomeModule module = SZHomeModule.fromJson(el);
      totalList.add(module);
    }

    return totalList;
  }
}
