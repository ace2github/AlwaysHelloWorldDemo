import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TextDemo extends StatelessWidget {
  String? phone = '18612345678';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TextDemo'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'HelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorldHelloWorld',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  backgroundColor: Colors.orange,
                  wordSpacing: 5.0),
              maxLines: 2, // 最大行数
              overflow: TextOverflow.ellipsis, // 超出显示...
            ),
            Text.rich(
              TextSpan(
                  text: '富文本：电话可点击  ',
                  style: TextStyle(color: Colors.orange, fontSize: 20),
                  children: [
                    TextSpan(
                      text: this.phone,
                      style: TextStyle(color: Colors.blue, fontSize: 25),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          print('拨打电话: ${this.phone}');
                        },
                    ),
                  ]),
            ),
            TextInputWidget(),
          ],
        ),
      ),
    );
  }
}

class TextInputWidget extends StatefulWidget {
  const TextInputWidget({Key? key}) : super(key: key);

  @override
  _TextInputWidgetState createState() => _TextInputWidgetState();
}

class _TextInputWidgetState extends State<TextInputWidget> {
  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    _editingController.addListener(() {
      print('用户名：${_editingController.text}');
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          TextField(
              autofocus: true, // 是否自动对焦
              decoration: InputDecoration(
                  hintText: '手机号码或者邮箱', 
                  prefixIcon: Icon(Icons.person),
                  border: InputBorder.none
              ),
              controller: _editingController,
          ),

          TextField(
              autofocus: false,
              decoration: InputDecoration(
                  labelText: '密码',
                  hintText: '输入登录密码',
                  prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true, // 是否隐藏输入内容，用于密码隐藏

              // 监听文本变化
              onChanged: (val) {
                print('输入的密码是：$val');
              })
        ],
      ),
      decoration: BoxDecoration(
        // 下滑线浅灰色，宽度1像素
        border: Border(left: BorderSide(color: Colors.orange, width: 3.0))
      ),
    );
  }
}
