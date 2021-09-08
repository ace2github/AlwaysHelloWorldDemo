
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ToolWidget extends StatelessWidget {
  const ToolWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tool widget'),),
      body: Column(
          children: [
            SwitchAndCheckWidget(),
            ProgressIndicatorWidget(),
          ],
        ),
    );
  }
}

///
/// Switch and Check
/// 
class SwitchAndCheckWidget extends StatefulWidget {
  const SwitchAndCheckWidget({ Key? key }) : super(key: key);

  @override
  _SwitchAndCheckWidgetState createState() => _SwitchAndCheckWidgetState();
}

class _SwitchAndCheckWidgetState extends State<SwitchAndCheckWidget> {
  bool switchValue = false;
  String switchText = 'switch';

  bool checkboxValue = true;
  String checkboxText = 'checkbox';

  void updateTextHandler() {
    this.switchText = this.switchValue ? "开" : "关";
    this.checkboxText = this.checkboxValue ? "选中" : "未选择";
  }

  @override
  void initState() {
    updateTextHandler();    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60, 
                child: Text(this.switchText, style: TextStyle(fontSize: 20, color: Colors.blue), textAlign: TextAlign.right,),
              ),
              Switch(
                value: this.switchValue, 
                onChanged: (val){
                  setState(() {
                    this.switchValue = val;
                    updateTextHandler();
                  });
              }),
            ],
          ),

          Row(
            children: [
              Container(
                width: 60,
                child: Text(this.checkboxText, style: TextStyle(fontSize: 20, color: Colors.orange), textAlign: TextAlign.right,),
              ),
              Checkbox(
                value: this.checkboxValue, 
                onChanged: (val){
                  setState(() {
                    this.checkboxValue = val!;
                    updateTextHandler();
                  });
              }),
            ],
          )
        ],
      ),
    );
  }
}

///
/// ProgressIndicator
/// 
class ProgressIndicatorWidget extends StatefulWidget {
  const ProgressIndicatorWidget({ Key? key }) : super(key: key);

  @override
  _ProgressIndicatorWidgetState createState() => _ProgressIndicatorWidgetState();
}

class _ProgressIndicatorWidgetState extends State<ProgressIndicatorWidget> {
  double linearProgress = 0;
  double circleProgress = 0;

  @override
  void initState() {
    this.linearProgress = 0.3;
    this.circleProgress = 0.5;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LinearProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ),
        Text('不设置value值，会执行动画'),
        LinearProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
          value: this.linearProgress,
        ), 

        CircularProgressIndicator(
          value: this.circleProgress,
          backgroundColor: Colors.lightGreen,
          valueColor: AlwaysStoppedAnimation(Colors.orange),
          strokeWidth: 1.0,
        ),
        Text('不设置value值，会执行动画'),
        CircularProgressIndicator(
          backgroundColor: Colors.grey,
          valueColor: AlwaysStoppedAnimation(Colors.blue),
        ), 
      ],
    );
  }
}