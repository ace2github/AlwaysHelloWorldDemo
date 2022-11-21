import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/model/SZFavoriteManager.dart';
import 'package:foodlike/model/SZMealModel.dart';
import 'package:foodlike/model/SZProviderManager.dart';
import 'package:foodlike/widgets/SZMealWidget.dart';
import 'package:provider/provider.dart';

class SZFavoritePage extends StatefulWidget {
  static final String routeName = "/favorite";
  const SZFavoritePage({super.key});

  @override
  State<SZFavoritePage> createState() => _SZFavoritePageState();
}

class _SZFavoritePageState extends State<SZFavoritePage> {
  late List<SZMealModel> likesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("收藏"),
      ),
      body:
          Consumer<SZProviderNotifierCenter>(builder: (context, value, child) {
        likesList = SZFavoriteManager.likeFoodList;
        print("update like list. ${likesList}");
        return ListView.builder(
          itemCount: likesList.length,
          itemBuilder: (context, index) {
            return SZMealWidget(likesList[index]);
          },
        );
      }),
    );
  }
}
