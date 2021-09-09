

import 'package:flutter/material.dart';

class ClipDemoPage extends StatelessWidget {
  const ClipDemoPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Clip Widget'),),
      body: Column(
        children: [
          ClipDemoWidget(),
          DecoratedBoxDemo(),
          SizeWidget()
        ],
      ),
    );
  }
}

class ClipDemoWidget extends StatelessWidget {
  const ClipDemoWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget avatar = Container(color: Colors.blue, width: 80, height: 80, child: Image(image: AssetImage('resources/zhongqiu.jpg'), fit: BoxFit.cover,),); 
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(child: avatar,),
        ClipRRect(borderRadius: BorderRadius.circular(5.0), child: avatar,),
      ],
    );
  }
}

class DecoratedBoxDemo extends StatelessWidget {
  const DecoratedBoxDemo({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(padding: EdgeInsets.all(20), child: Text('DecoratedBox:装饰组件外观，如背景、边框、渐变等'),),
        DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3.0),
            boxShadow: [
              BoxShadow(color: Colors.black54, offset: Offset(5.0, 5.0), blurRadius: 8.0),
            ],
            gradient: LinearGradient(colors: [Colors.red, Colors.orange])
          ),
          child: TextButton(onPressed: () {  }, child: Text('Press Me'),),
        ),
      ],
    );
  }
}

class SizeWidget extends StatelessWidget {
  const SizeWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 不设置尺寸的组件
    Widget testBox = Container(color: Colors.orange,);

    return Column(
      children: [
        Container(padding: EdgeInsets.all(10), child: Text('尺寸限制器容器：对子组件添加额外的约束。'),),
        ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: 50.0,
            minWidth: double.infinity // 尽可能大
          ),
          child: testBox,
        ),

        //间距
        Container(height: 10,),
        SizedBox(child: testBox, width: 100, height: 100,),       

        Container(padding: EdgeInsets.all(10), child: Text('指定子组件的长宽比: w:h = 3:1'),), 
        AspectRatio(aspectRatio: 3/1, child: testBox,),

        Container(padding: EdgeInsets.all(10), child: Text('根据父容器宽高的百分比来设置子组件宽高'),), 
        Container(
          color: Colors.blue,
          height: 100, 
          width: 100, 
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.3,
            child: testBox,
          ),
        ),
      ],
    );
  }
}