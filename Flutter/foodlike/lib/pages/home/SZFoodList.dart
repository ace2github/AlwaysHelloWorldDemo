import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/model/SZHomeModule.dart';
import 'package:foodlike/model/SZMealModel.dart';

import '../../widgets/SZMealWidget.dart';

class SZFoodListPage extends StatefulWidget {
  static const String routeName = "/foodlist";
  @override
  State<SZFoodListPage> createState() => _SZFoodListPageState();
}

class _SZFoodListPageState extends State<SZFoodListPage> {
  late SZHomeModule _moduleInfo;
  late final List<SZMealModel> _foodList = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    print(">>> foodlist didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SZFoodListPage oldWidget) {
    // TODO: implement didUpdateWidget
    print(">>> foodlist didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(">>> foodlist build");
    _moduleInfo = ModalRoute.of(context)?.settings.arguments as SZHomeModule;

    for (var i = 0; i < 100; i++) {
      SZMealModel mm = SZMealModel();
      mm.url = "https://picsum.photos/200/300?random=${i}";
      mm.title = "${_moduleInfo.title} - ${i}";
      mm.liked = i % 2 == 0 ? true : false;
      _foodList.add(mm);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_moduleInfo.title ?? ""),
      ),
      body: ListView.builder(
        itemCount: 68,
        itemBuilder: (context, index) {
          return SZMealWidget(_foodList[index]);
        },
      ),
    );
  }
}
