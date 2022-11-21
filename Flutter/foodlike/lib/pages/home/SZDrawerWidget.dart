import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/pages/home/SZFilterPage.dart';
import 'package:foodlike/themes/SZAppThemes.dart';

class SZDrawerMain extends StatelessWidget {
  const SZDrawerMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: Drawer(
        child: SZDrawerWidget(),
      ),
    );
  }
}

class SZDrawerWidget extends StatefulWidget {
  const SZDrawerWidget({super.key});

  @override
  State<SZDrawerWidget> createState() => _SZDrawerWidgetState();
}

class _SZDrawerWidgetState extends State<SZDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
              top: 60,
            ),
            width: double.infinity,
            height: 100,
            color: Colors.pink,
            child: Text(
              "侧边框",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: SZAppThemes.fontNormal),
            ),
          ),
          buildListTitle(Icon(Icons.filter), "过滤", () {
            Navigator.of(context).pushNamed(SZFilterPage.routeName);
          }),
          buildListTitle(Icon(Icons.error), "未知页面", () {
            Navigator.of(context).pushNamed("/err");
          }),
          buildListTitle(Icon(Icons.close), "关闭", () {
            Navigator.of(context).pop();
          }),
        ],
      ),
    );
  }

  Widget buildListTitle(Icon icon, String title, Function handler) {
    return ListTile(
      title: Text(title),
      leading: icon,
      minLeadingWidth: 0.0,
      onTap: () {
        handler();
      },
    );
  }
}
