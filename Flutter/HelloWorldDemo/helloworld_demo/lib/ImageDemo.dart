import 'package:flutter/material.dart';

class ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Demo'),
      ),
      body: Column(
        children: [
          Center(
              child: Column(children: [
            Image(
              image: AssetImage('resources/share_dynamic_icon.png'),
              width: 200,
              height: 50,
            ),
            Text('2x和3x：AssetImage'),
          ])),
          Center(
            child: Column(children: [
              Image.asset('resources/parent_type.png'),
              Text('图片文件夹：Image.asset'),
            ]),
          ),
          Center(
              child: Column(children: [
            Image(
              image: NetworkImage(
                  'https://www.baidu.com/img/PCtm_d9c8750bed0b3c7d089fa7d55720d6cf.png'),
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            Text('网络图片: NetworkImage'),
          ])),
          Center(child: IconDemoWidget(),)
        ],
      ),
    );
  }
}

///
/// 字体图标 IconFont
///
class IconDemoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('字体图标 IconFont（如下）', style: TextStyle(fontSize: 24,),) ,
      Text("\uE914 \uE000 \uE90D", style: TextStyle(fontFamily: "MaterialIcons", fontSize: 30.0, color: Colors.green),),
      Row(
        children: [
          Icon(Icons.accessible, color:Colors.blue),
          Icon(Icons.error, color:Colors.green, size: 50,),
          Icon(Icons.fingerprint, color:Colors.green,),
        ], 
        mainAxisAlignment: MainAxisAlignment.center,)
    ],);
  }
}
