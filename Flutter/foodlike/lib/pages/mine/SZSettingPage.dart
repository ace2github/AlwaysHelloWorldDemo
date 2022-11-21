import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../common/common.dart';

class SZSettingPage extends SZBaseStatelessWidget {
  static final String routeName = "/setting";
  @override
  SZBaseWidgetConfig buildBaseConfig(context) {
    SZBaseWidgetConfig cfg = super.buildBaseConfig(context);
    cfg.title = "设置列表";
    return cfg;
  }

  @override
  Widget buildBody(BuildContext context) {
    List<Map<String, String>> settings = [
      {"name": "名字", "value": "晖"},
      {"name": "性别", "value": "男"},
      {"name": "头像", "value": ""}
    ];
    return ListView.builder(
        itemCount: settings.length,
        itemExtent: 40,
        itemBuilder: (context, index) {
          Map<String, String> sm = settings[index];
          return ListTile(
            title: Text(sm["name"] ?? ""),
            trailing: Container(
              width: 200,
              // color: Colors.orange,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    sm["value"] ?? "",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  )
                ],
              ),
            ),
          );
        });
  }
}
