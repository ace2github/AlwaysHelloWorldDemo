
import 'package:flutter/material.dart';

class LayoutDemoPage extends StatelessWidget {
  const LayoutDemoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('layout'),),
      body: Column(
        children: [
          FlexLayoutWidget(),
          RowColumnLayoutWidget(),
          WrapLayoutWidget(),
        ],
      )
    );
  }
}

///
/// 线性布局，Row 和 Column
///
class RowColumnLayoutWidget extends StatelessWidget {
  const RowColumnLayoutWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: Colors.green[10],
          child: Column(
            children: [
              Row(
                textDirection: TextDirection.rtl, // 从左边或者右边开始布局
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('123456')),
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('abcdef')),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('123456')),
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('abcdef')),
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('你好')),
                ],
              ),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                verticalDirection: VerticalDirection.up,
                children: [
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('123456', style: TextStyle(fontSize: 40),)),
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('abcdef')),
                  Padding(padding: EdgeInsets.only(left: 5, top: 5), child: Text('你好', style: TextStyle(fontSize: 30),)),
                ],
              ),
            ],
          ),
        ),
      
        Container(
          padding: EdgeInsets.only(top: 30),
          height: 100,
          color: Colors.green[100],
          child: Column(
            // 文字从中间开始布局
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('123456789'),
              Text('world')
            ],
          ),
        ),
      ],
    );
  }
}

///
/// Flex布局
///
class FlexLayoutWidget extends StatelessWidget {
  const FlexLayoutWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Flex的两个子widget按1：2来占据水平空间  
        Flex(
          direction: Axis.horizontal,
          children: [
            Expanded(flex: 1, child: Container(height: 30, color: Colors.blue[100],)),
            Expanded(flex: 2, child: Container(height: 30, color: Colors.blue[200],)), 
          ],
        ),

        // 设置间距
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: SizedBox(
            height: 100,
            // 三个组件按照2：1：1 占据垂直控件
            child: Flex(
              direction: Axis.vertical,
              children: [
                Expanded(flex: 2 ,child: Container(height: 30, color: Colors.orange[100],)),
                Spacer(flex: 1,),
                Expanded(flex: 1, child: Container(height: 30, color: Colors.orange[200],))
              ],
            ),
          ),
        ),
      ],
    );
  }
}


///
/// 流式布局 Wrap（解决Flex超出布局区域，页面报错）
/// 例如：Row默认只有一行，如果超出屏幕不会折行。
///
class WrapLayoutWidget extends StatelessWidget {
  const WrapLayoutWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 5, // 主轴方向子widget的间距
          alignment: WrapAlignment.center, // 主轴方向的对齐妨害
          runSpacing: 0, // 纵轴方向的间距
          runAlignment: WrapAlignment.start, // 纵轴方向的对齐方式
          children: [
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('1')),
              label: Text('中国'),
           ),
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('2')),
              label: Text('唐朝'),
           ),
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('3')),
              label: Text('河西走廊'),
            ),
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('4')),
              label: Text('Nature'),
            ),
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('5')),
              label: Text('123123123'),
            ),
           Chip(
              avatar: CircleAvatar(backgroundColor: Colors.blue, child: Text('6')),
              label: Text('笑哈哈'),
            ),
          ],
        ),

        Wrap(
          spacing: 5,
          alignment: WrapAlignment.start,
          runSpacing: 5,
          runAlignment: WrapAlignment.start,
          children: [
            Container(width: 80.0, height:80.0, color: Colors.red,),
            Container(width: 80.0, height:80.0, color: Colors.black,),
            Container(width: 80.0, height:80.0, color: Colors.yellow,),
            Container(width: 80.0, height:80.0, color: Colors.blue,),
            Container(width: 80.0, height:80.0, color: Colors.orange,),
            Container(width: 80.0, height:80.0, color: Colors.purple,),
            Container(width: 80.0, height:80.0, color: Colors.pink,),
            Container(width: 80.0, height:80.0, color: Colors.green,),
          ],
        ),
      ],
    );
  }
}

//
// 一般很少会使用Flow，因为其过于复杂，需要自己实现子widget的位置转换，在很多场景下首先要考虑的是Wrap是否满足需求。
// 

