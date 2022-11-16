import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'ProviderDemo.dart';

class AppStatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("app state")),
      body: CounterWidgetPage(
        child: Column(
          children: [MyWidget_1(), MyWidget_2(), MyWidget_3()],
        ),
      ),
      floatingActionButton: Consumer<CustormProvider>(
        builder: (context, value, child) {
          return FloatingActionButton(
            child: child,
            onPressed: () {
              value.timerCount += 1;
            },
          );
        },
        child: Text("Add"),
      ),
    );
  }
}

/*
* 使用InheritedWidget
*/
class CounterWidgetPage extends InheritedWidget {
  final int valCounter = 150;
  CounterWidgetPage({required Widget child}) : super(child: child);

  static CounterWidgetPage of(BuildContext context) {
    // 沿着elementtree查找对应的最近CounterWidgetPage，返回element
    return context.dependOnInheritedWidgetOfExactType()!;
  }

  @override
  bool updateShouldNotify(covariant CounterWidgetPage oldWidget) {
    return oldWidget.valCounter != valCounter;
  }
}

class MyWidget_1 extends StatelessWidget {
  const MyWidget_1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int val = CounterWidgetPage.of(context).valCounter;
    return Card(
      color: Colors.red,
      child: Text("count = ${val}"),
    );
  }
}

class MyWidget_2 extends StatelessWidget {
  const MyWidget_2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int val = CounterWidgetPage.of(context).valCounter;
    return Container(
      child: Text("t2: ${val}"),
    );
  }
}

/*
* 使用provider方式
*/
class MyWidget_3 extends StatelessWidget {
  const MyWidget_3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 这种方法非常的不好
    return Container(
      child: Consumer<CustormProvider>(
        builder: (context, value, child) {
          return Text("t3=${value.timerCount}");
        },
      ),
    );
  }
}
