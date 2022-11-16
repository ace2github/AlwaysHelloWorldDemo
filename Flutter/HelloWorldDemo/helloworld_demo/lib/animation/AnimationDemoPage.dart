import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

// 混入
class MyAnimationWidget extends StatefulWidget {
  const MyAnimationWidget({Key? key}) : super(key: key);

  @override
  State<MyAnimationWidget> createState() => _MyAnimationWidgetState();
}

class _MyAnimationWidgetState extends State<MyAnimationWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1),
        lowerBound: 0.0,
        upperBound: 1.0);

    // 设置curve
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.elasticInOut);

    _animation = Tween(begin: 50.0, end: 150.0).animate(_animationController);

    _animation.addListener(() {
      // 会重新构建widget，调用build，需要进行优化
      setState(() {});
    });
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("text")),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _animationController.forward();
          },
        ),
        body: Center(
          child: Container(
            width: _animationController.value,
            height: _animationController.value,
            color: Colors.blue,
          ),
        ));
  }
}
