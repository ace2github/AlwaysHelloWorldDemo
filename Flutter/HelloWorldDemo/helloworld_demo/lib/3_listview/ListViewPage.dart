import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:helloworld_demo/network/HttpManager.dart';
import 'package:helloworld_demo/network/NetworkConfig.dart';
import 'package:helloworld_demo/themes/DeviceInfo.dart';

// class MyListViewWidget extends StatelessWidget {
//   const MyListViewWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ListView"),
//       ),
//       body: Container(
//         child: ListView(
//           children: [
//             Padding(
//               padding: EdgeInsets.all(1.0),
//               child: Text("好好学习天天向上"),
//             ),
//             Padding(
//               padding: EdgeInsets.all(1.0),
//               child: Text("好好学习天天向上"),
//             ),
//             Padding(
//               padding: EdgeInsets.all(1.0),
//               child: Text("好好学习天天向上"),
//             ),
//             Padding(
//               padding: EdgeInsets.all(1.0),
//               child: Text("好好学习天天向上"),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// ListTitle
// class MyListViewWidget extends StatelessWidget {
//   const MyListViewWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ListView"),
//       ),
//       body: Container(
//         child: ListView(
//           children: [
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             ),
//             ListTile(
//               leading: Icon(
//                 Icons.people,
//                 size: 36,
//               ),
//               title: Text("name -1"),
//               subtitle: Text("电话联系人"),
//               trailing: Icon(Icons.arrow_forward_ios),
//               onTap: () {
//                 print("click now");
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MyListViewWidget extends StatelessWidget {
//   const MyListViewWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ListView"),
//       ),
//       body: Container(
//         child: ListView.builder(
//             itemCount: 68,
//             itemExtent: 80,
//             itemBuilder: (context, index) {
//               return ListTile(
//                 title: Text("title ${index}"),
//                 subtitle: Text("subtitle ${index}"),
//               );
//             }),
//       ),
//     );
//   }
// }

// class MyListViewWidget extends StatelessWidget {
//   Divider blue = Divider(color: Colors.blue);
//   Divider red = Divider(color: Colors.red);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ListView"),
//       ),
//       body: Container(
//         child: ListView.separated(
//           itemCount: 68,
//           itemBuilder: (context, index) {
//             return ListTile(
//               title: Text("title ${index}"),
//               subtitle: Text("subtitle ${index}"),
//             );
//           },
//           separatorBuilder: (context, index) {
//             return 0 == index % 2 ? red : blue;
//           },
//         ),
//       ),
//     );
//   }
// }

class MyListViewWidget extends StatefulWidget {
  const MyListViewWidget({Key? key}) : super(key: key);

  @override
  State<MyListViewWidget> createState() => _MyListViewWidgetState();
}

class _MyListViewWidgetState extends State<MyListViewWidget> {
  bool _isShowTop = false;
  late ScrollController _scrollController;

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.removeListener(() {});
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    // HttpManager.request("https://douban.uieee.com/v2/movie/top250?start=0&count=20", method: HttpMethods.get
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      print(_scrollController.offset);
      bool temp = _scrollController.offset > 1000;
      if (temp != _isShowTop) {
        setState(() {});
        _isShowTop = temp;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ListView"),
      ),
      floatingActionButton: !_isShowTop
          ? null
          : FloatingActionButton(
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 500), curve: Curves.ease);
              }),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            leading: Container(
              width: 60.0.px,
              height: 60,
              child: Image.network(
                  "https://picsum.photos/200/300?random=${index}"),
            ),
            title: Text("title ${index}"),
            trailing: Icon(Icons.arrow_forward_ios),
          );
        },
        itemCount: 168,
        itemExtent: 68,
        controller: _scrollController,
      ),
    );
  }
}
