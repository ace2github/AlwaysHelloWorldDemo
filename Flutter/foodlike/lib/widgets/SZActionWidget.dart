import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class SZActionWidget extends StatelessWidget {
  final Widget _icon;
  final String _name;
  SZActionWidget(this._icon, this._name);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _icon,
        SizedBox(
          width: 3.0,
        ),
        Text(_name)
      ],
    );
  }
}
