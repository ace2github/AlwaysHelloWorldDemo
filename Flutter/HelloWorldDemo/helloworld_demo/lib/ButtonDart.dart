import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///
/// MaterialStateProperty.all() 方法是设置点击事件所有状态下的样式。
/// MaterialStateProperty.resolveWith() 可拦截分别设置不同状态下的样式。
/// 

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Button Widget'),),
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          children: [
            TextButton(
              onPressed: (){
                print('click button');
              }, 
              child: Image.asset('resources/test.png')
            ),

            TextButton(
              onPressed: (){
                print('click me action!');
              },
              child: Text('TextButton')
            ),

            TextButton(
              onPressed: (){
                print('click me');
              }, 
              child: Text('TextButton'),
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  TextStyle(fontSize: 20),
                ),
                // 圆角按钮
                shape: MaterialStateProperty.all(StadiumBorder()), 
                //设置按钮内边距
                padding: MaterialStateProperty.all(EdgeInsets.all(10)), 
                //设置水波纹颜色
                overlayColor: MaterialStateProperty.all(Colors.yellow),
                //设置阴影  不适用于这里的TextButton
                elevation: MaterialStateProperty.all(0),

                //背景颜色
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  //设置按下时的背景颜色
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.blue[200];
                  }
                  //默认不使用背景颜色
                  return null;
                }),
                //更优美的方式来设置
                foregroundColor: MaterialStateProperty.resolveWith(
                  (states) {
                    if (states.contains(MaterialState.focused) && !states.contains(MaterialState.pressed)) {
                      //获取焦点时的颜色
                      return Colors.blue;

                    } else if (states.contains(MaterialState.pressed)) {
                      //按下时的颜色
                      return Colors.deepPurple;
                    }
                    //默认状态使用灰色
                    return Colors.grey;
                  },
                ),
              ),
            ),

            // ElevatedButton 
            ElevatedButton(
              onPressed: (){}, 
              child: Text('ElevatedButton')
            ),

            // OutlinedButton
            OutlinedButton(
              onPressed: (){},
              child: Text('OutlinedButton'),
            ),

            FloatingActionButton(onPressed: (){}, child: Text('+'),)
          ],
        ),
      ),
    );
  }
}