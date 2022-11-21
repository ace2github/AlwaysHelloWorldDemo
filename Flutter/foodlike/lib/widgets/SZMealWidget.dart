import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/model/SZMealModel.dart';
import 'package:foodlike/pages/home/SZDetailPage.dart';

import 'SZActionWidget.dart';

class SZMealWidget extends StatefulWidget {
  final SZMealModel foodModel;
  SZMealWidget(this.foodModel, {super.key});

  @override
  State<SZMealWidget> createState() => _SZMealWidgetState();
}

class _SZMealWidgetState extends State<SZMealWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(SZDetailPage.routeName, arguments: widget.foodModel);
      },
      child: Card(
        margin: EdgeInsets.all(10.0),
        elevation: 5, // 阴影
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          children: [buildBaseInfo(context), buildBottom(context)],
        ), // 圆角
      ),
    );
  }

  Widget buildBaseInfo(BuildContext context) {
    double radius = 10.0;
    return Container(
      height: 160,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(radius),
                topRight: Radius.circular(radius)),
            child: Image.network(
              widget.foodModel.url,
              width: double.infinity,
              height: 160,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            width: double.infinity,
            height: 40.0,
            padding: EdgeInsets.all(5.0),
            decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(radius)),
            child: Text(
              widget.foodModel.title,
              style: TextStyle(color: Colors.white),
            ),
            alignment: Alignment.centerLeft,
          )
        ],
      ),
    );
  }

  Widget buildBottom(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SZActionWidget(Icon(Icons.schedule), widget.foodModel.time),
          SZActionWidget(Icon(Icons.restaurant), widget.foodModel.level),
          SZActionWidget(
              Icon(widget.foodModel.liked
                  ? Icons.favorite_border
                  : Icons.favorite),
              "收藏")
        ],
      ),
    );
  }
}
