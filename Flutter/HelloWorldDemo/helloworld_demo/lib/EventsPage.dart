import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:event_bus/event_bus.dart';

final gEventBus = EventBus();

class MyEventWidget extends StatelessWidget {
  const MyEventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int count = 0;
    return Scaffold(
        appBar: AppBar(
          title: Text("event"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("+"),
          onPressed: () {
            count += 1;
            gEventBus.fire("EventBus:update: ${count}");
          },
        ),
        body: Center(
          child: Listener(
            onPointerDown: (event) {
              print("down: ${event.position}  ${event.localPosition}");
            },
            onPointerMove: (event) {
              print("move: ${event.position}");
            },
            onPointerUp: (event) {
              print("up: ${event.position}");
            },
            child: Container(
              width: 250,
              height: 350,
              color: Colors.blue,
              child: _MyEventTextWidget(),
            ),
          ),
        ));
  }
}

class _MyEventTextWidget extends StatelessWidget {
  const _MyEventTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyEventLabelWidget(),
    );
  }
}

class MyEventLabelWidget extends StatefulWidget {
  const MyEventLabelWidget({Key? key}) : super(key: key);

  @override
  State<MyEventLabelWidget> createState() => _MyEventLabelWidgetState();
}

class _MyEventLabelWidgetState extends State<MyEventLabelWidget> {
  String _message = "我定义";
  var eventHandler = null;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    eventHandler.cancel();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    print("ev bus on");
    eventHandler = gEventBus.on<String>().listen((event) {
      setState(() {
        _message = "${event}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(_message),
      ),
    );
  }
}
