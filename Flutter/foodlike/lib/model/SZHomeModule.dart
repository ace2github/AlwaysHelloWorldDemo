import 'dart:ui';

class SZHomeModule {
  String? id;
  String? title;
  String? color;

  SZHomeModule({this.id, this.title, this.color});

  SZHomeModule.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    color = json['color'];
  }

  Color get realColor {
    // 十六进制的颜色值，不包含透明度
    final colorInt = int.parse(color ?? "FFFFFF", radix: 16);
    // 添加透明度，采用或运算符 0xFF000000
    return Color(colorInt | 0xFF000000);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['color'] = this.color;
    return data;
  }
}
