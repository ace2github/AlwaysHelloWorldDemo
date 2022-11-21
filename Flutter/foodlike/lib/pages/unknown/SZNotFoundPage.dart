import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SZNotFoundPage extends StatelessWidget {
  static final String routeName = "/notfound";
  const SZNotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("错误路由信息"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Text("404页面"),
      ),
    );
  }
}
