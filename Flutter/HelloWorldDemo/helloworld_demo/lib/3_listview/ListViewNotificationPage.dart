import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListViewNotificationPage extends StatefulWidget {
  const ListViewNotificationPage({Key? key}) : super(key: key);

  @override
  State<ListViewNotificationPage> createState() =>
      _ListViewNotificationPageState();
}

class _ListViewNotificationPageState extends State<ListViewNotificationPage> {
  int _progress = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("ListView"),
        ),
        body: NotificationListener(
          onNotification: (notification) {
            if (notification is ScrollStartNotification) {
              print("start scrolling...");
            } else if (notification is ScrollEndNotification) {
              print("end scroll");
            } else if (notification is ScrollUpdateNotification) {
              // 当前滚动的位置和总长度
              final currentPixel = notification.metrics.pixels;
              final totalPixel = notification.metrics.maxScrollExtent;

              double progress = currentPixel / totalPixel;
              setState(() {
                _progress = (progress * 100).toInt();
              });
            }
            return false;
          },
          child: Stack(
            alignment: Alignment(.5, .5),
            children: [
              ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("title ${index}"),
                    trailing: Icon(Icons.arrow_forward_ios),
                  );
                },
                itemCount: 168,
                itemExtent: 68,
              ),
              CircleAvatar(
                  radius: 40,
                  child: Text(
                    "${_progress}",
                    style: TextStyle(color: Colors.orange),
                  ),
                  backgroundColor: Colors.black54)
            ],
          ),
        ));
  }
}
