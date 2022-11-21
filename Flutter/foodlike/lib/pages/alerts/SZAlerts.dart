import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showBottomSheetView(BuildContext context) {
  List<String> sheets = ["跳转到详情页", "删除记录", "转发"];
  showModalBottomSheet(
      isScrollControlled: false,
      isDismissible: false,
      context: context,
      builder: (context) {
        return Container(
          width: double.infinity,
          color: Colors.pink,
          height: sheets.length * 40 + 60,
          child: ListView.builder(
              itemCount: sheets.length,
              itemExtent: 40,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(sheets[index]),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                );
              }),
        );
      });
}

void showAlertView(BuildContext context) {
  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("title"),
          content: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                child: Text("确定是否要退出吗？"),
                alignment: Alignment(0, 0),
              ),
              Align(
                child: Text("哈哈哈哈"),
                alignment: Alignment(0, 0),
              ),
            ],
          ),
          actions: [
            CupertinoDialogAction(
              child: Text("取消"),
              onPressed: () {
                Navigator.pop(context);
                print("取消");
              },
            ),
            CupertinoDialogAction(
              child: Text("确定"),
              onPressed: () {
                Navigator.pop(context);
                print("确定");
              },
            ),
          ],
        );
      });
}
