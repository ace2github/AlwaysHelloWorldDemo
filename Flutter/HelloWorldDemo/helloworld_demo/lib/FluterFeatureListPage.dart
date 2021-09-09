import 'package:flutter/material.dart';

import 'TextDemo.dart';
import 'ImageDemo.dart';
import 'ToolWidget.dart';
import 'ButtonDart.dart';
import 'LayoutDemoPage.dart';
import 'LayoutDemoPage_2.dart';
import 'ClipDemoPage.dart';

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

    CellItem('Layout', (context){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return new LayoutDemoPage();
      }));
    }),

    CellItem('Layout 2', (context){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return new LayoutDemoPage_2();
      }));
    }),

    CellItem('Container & Clip', (context){
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return new ClipDemoPage(); 
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
          if (null != item.clickActionHandler) {
            item.clickActionHandler!(context);
          }

          print(item.title);
        },
        child: Text(
          item.title, 
          textAlign: TextAlign.start, 
          style: TextStyle(fontSize: 20.0,),
        )
    );
  }
}



/*
 * CellItem对应的的结构体
 */

// 重命名：函数类型
typedef ClickAction = void Function(BuildContext context);

class CellItem extends Object {
  String title = '';
  ClickAction? clickActionHandler; // 点击跳转事件

  /*
   * 构造函数
   */
  CellItem(this.title, this.clickActionHandler);
}
