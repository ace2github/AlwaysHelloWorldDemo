import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SZBaseWidgetConfig {
  String title = "";
}

class SZBaseStatelessWidget extends StatelessWidget {
  late final SZBaseWidgetConfig _baseCfg;

  Scaffold buildScaffold(BuildContext context, SZBaseWidgetConfig cfg) {
    return Scaffold(
      appBar: AppBar(title: Text(cfg.title)),
      body: buildBody(context),
    );
  }

  SZBaseWidgetConfig buildBaseConfig(BuildContext context) {
    return SZBaseWidgetConfig();
  }

  Widget buildBody(BuildContext context) {
    return Container(
      child: Text("请自定义页面"),
    );
  }

  @override
  Widget build(BuildContext context) {
    _baseCfg = buildBaseConfig(context);
    return buildScaffold(context, _baseCfg);
  }
}

// class SZBaseStatefulWidget extends StatefulWidget {
//   const SZBaseStatefulWidget({super.key});

//   @override
//   State<SZBaseStatefulWidget> createState() => _SZBaseStatefulWidgetState();
// }

// class _SZBaseStatefulWidgetState extends State<SZBaseStatefulWidget> {
//   late final SZBaseWidgetConfig _baseCfg;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _baseCfg = widget.buildBaseConfig(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.buildScaffold(context, _baseCfg);
//   }
// }

extension SZWidgetExt on Widget {}
