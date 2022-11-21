import 'package:flutter/cupertino.dart';
import 'package:foodlike/model/SZMealModel.dart';
import 'package:foodlike/model/SZProviderManager.dart';

class SZFavoriteManager {
  static final Map<String, SZMealModel> _likesMapper = {};

  static addMeal(SZMealModel model) {
    if (null != model && model.key.isNotEmpty) {
      String key = model.key + model.title;
      _likesMapper[key] = model;
      SZProviderNotifierCenter.shareInstance.changeLike = true;
    }
  }

  static removeMeal(SZMealModel model) {
    if (null != model && model.key.isNotEmpty) {
      String key = model.key + model.title;
      _likesMapper.remove(key);
      SZProviderNotifierCenter.shareInstance.changeLike = true;
    }
  }

  static List<SZMealModel> get likeFoodList {
    return _likesMapper.values.toList();
  }
}
