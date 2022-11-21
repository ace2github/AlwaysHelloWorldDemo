import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/themes/SZAppThemes.dart';

class SZFilterPage extends StatefulWidget {
  static final String routeName = "/filter";
  const SZFilterPage({super.key});

  @override
  State<SZFilterPage> createState() => _SZFilterPageState();
}

class _SZFilterPageState extends State<SZFilterPage> {
  @override
  Widget build(BuildContext context) {
    List<String> settings = [];
    return Scaffold(
      appBar: AppBar(
        title: Text("filter"),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            // color: Colors.pink,
            child: Text(
              "Header",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: SZAppThemes.fontNormal),
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              createCellWidget("蛋白质", "蛋白质是。。。", (val) {}),
              createCellWidget("糖分", "过多糖分会引起肥胖", (val) {}),
              createCellWidget("钙含量", "该有助于骨骼的生长", (val) {}),
              createCellWidget("维生素含量", "高维生素有助于身体抗氧化能力", (val) {}),
            ],
          ))
        ],
      ),
    );
  }

  Widget createCellWidget(String title, String desc, Function handler,
      {bool open = false}) {
    return ListTile(
      title: Text(title),
      subtitle: Text(desc),
      trailing: Switch(
        value: open,
        onChanged: (value) {
          handler(value);
        },
      ),
    );
  }
}
