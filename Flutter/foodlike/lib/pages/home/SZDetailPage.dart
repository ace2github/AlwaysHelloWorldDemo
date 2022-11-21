import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/model/SZMealModel.dart';
import 'package:foodlike/themes/SZAppThemes.dart';

import '../../model/SZFavoriteManager.dart';

class SZDetailPage extends StatelessWidget {
  static final String routeName = "/detail";
  late SZMealModel _mealModel;
  @override
  Widget build(BuildContext context) {
    print(">>> fooddetail build");
    _mealModel = ModalRoute.of(context)?.settings.arguments as SZMealModel;
    return Scaffold(
      appBar: AppBar(
        title: Text("食谱详情"),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, bottom: 30),
        child: SZDetailContentWidget(_mealModel),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite_border),
        onPressed: () {
          SZFavoriteManager.addMeal(_mealModel);
        },
      ),
    );
  }
}

class SZDetailContentWidget extends StatelessWidget {
  final SZMealModel _mealModel;
  const SZDetailContentWidget(this._mealModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildTitle(context, "标题：${_mealModel.title}"),
          Container(
            padding: EdgeInsets.all(15.0),
            height: 260,
            width: double.infinity,
            child: Image.network(
              _mealModel.url,
              fit: BoxFit.cover,
            ),
          ),
          buildDesc(context,
              "西红柿炒鸡蛋是以西红柿，鸡蛋为主料制作的家常菜。味道酸甜可口，特别下饭。\n色泽鲜艳，酸甜爽口，口感爽滑，色香味浓，增加食欲。"),
          buildTitle(context, "制作方法"),
          buildContentList(
              context, ["4个西红柿", "一汤匙橄榄油", "1个洋葱", "250克意大利面", "香料", "奶酪（可选）"]),
          buildTitle(context, "制作材料"),
          buildContentList(
              context,
              [
                "把西红柿和洋葱切成小块。",
                "烧开水煮沸后加盐。",
                "把意大利面放进开水里，大约10到12分钟就可以做好。",
                "同时加热一些橄榄油，加入切好的洋葱。",
                "两分钟后，加入番茄片、盐、胡椒和其他香料。",
                "一旦意大利面做好了，调味汁就会做好。",
                "在成品盘上随意加些奶酪。"
              ],
              style: 1)
        ],
      ),
    );
  }

  Widget buildTitle(BuildContext context, String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 15),
      child: Text(
        title,
        style: TextStyle(fontSize: SZAppThemes.fontNormal),
      ),
    );
  }

  Widget buildDesc(BuildContext context, String desc) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Text(
        desc,
        style: TextStyle(fontSize: SZAppThemes.fontSmall),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget buildContentList(BuildContext context, List<String> list,
      {int style = 0}) {
    double cellHeight = 40;
    return Container(
      // height: cellHeight * list.length,
      width: MediaQuery.of(context).size.width - 15 * 2, // 媒体查询
      // color: Colors.grey,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      child: ListView.builder(
        shrinkWrap: true, // 根据内容计算高度；默认底部会有内边距，需要去掉
        physics: NeverScrollableScrollPhysics(), // 禁止滚动
        padding: EdgeInsets.zero,
        itemCount: list.length,
        itemBuilder: (context, index) {
          if (1 == style) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orange,
                child: Text("#${index}"),
              ),
              title: Text(list[index]),
            );
          }

          return Card(
            color: Colors.pinkAccent,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Text(list[index]),
            ),
          );
        },
      ),
    );
  }
}
