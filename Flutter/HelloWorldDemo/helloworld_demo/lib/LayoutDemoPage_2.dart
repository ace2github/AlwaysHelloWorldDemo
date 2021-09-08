import 'package:flutter/material.dart';

class LayoutDemoPage_2 extends StatelessWidget {
  const LayoutDemoPage_2({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('layout'),),
      body: Column(
        children: [
          StackLayoutWidget(),
          AlignLayoutWidget()
        ],
      )
    );
  }
}


///
/// Stack
///  组件允许在z轴上进行堆叠，可以控制超出区域的裁剪
///  Stack外部的要有宽高，否则报错
/// 
class StackLayoutWidget extends StatelessWidget {
  const StackLayoutWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(child: Container(width: 100, height: 100, color: Colors.green,)),
              Positioned(child: Container(width: 70, height: 70, color: Colors.red,)),
              Positioned(child: Container(width: 40, height: 40, color: Colors.blue,)),
            ],
          ),
        ),
        
        Container(
          padding: EdgeInsets.all(10),
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.hardEdge, // 裁剪
            children: [
              Positioned(top: 10, left: 10, child: Container(width: 100, height: 100, color: Colors.green,)),
              Positioned(top: 20, left: 20, child: Container(width: 100, height: 100, color: Colors.red,)),
              Positioned(top: 30, left: 30, child: Container(width: 100, height: 100, color: Colors.blue,)),
            ],
          ),
        ), 

        Container(
          height: 150,
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.expand, // 未定位widget占满Stack整个空间
            children: [
              // 未被定位
              Container(width: 30, height: 30, color: Colors.blue,), 

              // 定位组件
              Positioned(top: 10, left: 10, child: Container(width: 60, height: 60, color: Colors.green,)),
              Positioned(top: 50, left: 50, child: Container(width: 60, height: 60, color: Colors.red,)),  
            ],
          ),
        ),
      ],
    );
  }
}

class AlignLayoutWidget extends StatelessWidget {
  const AlignLayoutWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 5.0),

        Row(
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.green[100],
              child: Align(
                alignment: Alignment.topRight,
                child: FlutterLogo(size: 60,),
              ),
            ),

            Container(
              width: 100,
              height: 100,
              color: Colors.orange[100],
              child: Align(
                alignment: Alignment(1.0, -2.0),
                child: FlutterLogo(size: 60,),
              ),
            ),

            Container(
              width: 100,
              height: 100,
              color: Colors.orange[200],
              child: Align(
                alignment: FractionalOffset(0.5, 0.5),
                child: FlutterLogo(size: 60,),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Container(
              color: Colors.grey[50], 
              child: Align(widthFactor: 1.0, heightFactor: 1.0, child: Container(width: 50, height: 50, color: Colors.orange),)
            ), 

            Container(
              color: Colors.grey[200], 
              child: Align(widthFactor: 2.0, heightFactor: 2.0, child: Container(width: 50, height: 50, color: Colors.blue),)
            ),
          
             Container(
              color: Colors.grey[400], 
              child: Align(widthFactor: 1.5, heightFactor: 1.5, child: Container(width: 50, height: 50, color: Colors.red),)
            ), 
          ],
        ),

        Container(height: 1.0, color: Colors.orange, padding: EdgeInsets.only(top: 2.0, bottom: 2.0),),

        Column(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text("Center"),
              ),
            ),

            DecoratedBox(
              decoration: BoxDecoration(color: Colors.red),
              child: Center(
                widthFactor: 5,
                heightFactor: 3,
                child: Text("Center"),
              ),
            )
          ],
        ),
      ],
    );
  }
}


