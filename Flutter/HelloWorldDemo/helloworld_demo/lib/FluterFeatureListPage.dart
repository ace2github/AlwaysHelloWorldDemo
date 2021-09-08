import 'package:flutter/material.dart';

import 'TextDemo.dart';
import 'ImageDemo.dart';
import 'ToolWidget.dart';
import 'ButtonDart.dart';

///
/// Flutter的组件功能学习列表
///
class FluterFeatureListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('组件学习(SingleChildScrollView)')),
      body: _FeatureListView(),
    );
  }
}

class _FeatureListView extends StatelessWidget {
  var dataList = <CellItem>[
    CellItem('Text', (context) => {
      // 页面的push和页面路由
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new TextDemo();
      }))
    }),

    CellItem('Image', (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new ImageDemo();
      }));
    }),

    CellItem('Tools', (context) {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return new ToolWidget();
      }));
    }),

    CellItem('Buttons', (context) { 
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return new ButtonWidget();
      }));
    }),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: dataList.map((e) => createCell(e, context)).toList(),
      ),
    );
  }

  Widget createCell(CellItem item, BuildContext context) {
    return TextButton(
        onPressed: () {
          // if (null != item.clickActionHandler) {
          //   item.clickActionHandler!(context);
          // }
          item.clickActionHandler!(context);

          print(item.title);
        },
        child: Text(item.title));
  }
}



/*
 * CellItem对应的的结构体
 */

typedef ClickAction = void Function(BuildContext context);

class CellItem extends Object {
  String title = '';
  ClickAction? clickActionHandler; // 点击跳转事件

  /*
   * 构造函数
   */
  CellItem(this.title, this.clickActionHandler);
}
