import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:foodlike/model/SZDataManager.dart';
import 'package:foodlike/model/SZHomeModule.dart';
import 'package:foodlike/pages/home/SZFoodList.dart';
import 'package:foodlike/themes/SZAppThemes.dart';

import 'SZDrawerWidget.dart';

class SZHomePage extends StatelessWidget {
  static final String routeName = "/home";
  const SZHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Home"),
          leading: IconButton(
            icon: Icon(Icons.interests),
            onPressed: () {
              // 左上角的按钮点击，这时候获取的context是父节点的context
              Scaffold.of(context).openDrawer();
              // Scaffold.of(context).closeDrawer();
            },
          )

          // leading: Builder(
          //   builder: (context) {
          //     return IconButton(
          //       icon: Icon(Icons.interests),
          //       onPressed: () {
          //         // 左上角的按钮点击，这时候的context是当前HomePage的
          //         Scaffold.of(context).openDrawer();
          //         // Scaffold.of(context).closeDrawer();
          //       },
          //     );
          //   },
          // ),
          ),
      body: SZMainModuleView(),
    );
  }
}

class SZMainModuleView extends StatefulWidget {
  const SZMainModuleView({super.key});

  @override
  State<SZMainModuleView> createState() => _SZMainModuleViewState();
}

////////////////////////////////////////////////////////////
// 主页面的widget
////////////////////////////////////////////////////////////
// class _SZMainModuleViewState extends State<SZMainModuleView> {
//   List<SZHomeModule> _moduleList = [];

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     SZDataManager.loadHomeModule().then((value) {
//       setState(() {
//         _moduleList = value;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//         padding: const EdgeInsets.all(10.0),
//         itemCount: _moduleList.length,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 2,
//             crossAxisSpacing: 20.0,
//             mainAxisSpacing: 20.0,
//             childAspectRatio: 1.5),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               print("${index}");
//             },
//             child: ModuleCellWidget(_moduleList[index]),
//           );
//         });
//   }
// }
class _SZMainModuleViewState extends State<SZMainModuleView> {
  List<String> _imageUrl = [];
  List<SZHomeModule> _moduleList = [];

  @override
  Widget build(BuildContext context) {
    _imageUrl = [
      'https://upload-images.jianshu.io/upload_images/5809200-a99419bb94924e6d.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
      'https://upload-images.jianshu.io/upload_images/5809200-736bc3917fe92142.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
      'https://upload-images.jianshu.io/upload_images/5809200-7fe8c323e533f656.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
      'https://upload-images.jianshu.io/upload_images/5809200-48dd99da471ffa3f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
      'https://upload-images.jianshu.io/upload_images/5809200-4de5440a56bff58f.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240',
    ];

    // FutureBuilder 使用会有局限性，每次它都会构建影响性能
    // 也不适用于分页加载的数据
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Container(
            height: 200,
            width: double.infinity,
            child: Swiper(
              itemCount: _imageUrl.length,
              autoplay: true,
              pagination: SwiperPagination(),
              itemBuilder: (context, index) {
                return Image.network(
                  _imageUrl[index],
                  fit: BoxFit.fill,
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: buildModuleList(context),
        )
      ],
    );
  }

  Widget buildModuleList(BuildContext context) {
    return FutureBuilder<List<SZHomeModule>>(
      future: SZDataManager.loadHomeModule(),
      builder: (context, snapshot) {
        if (snapshot.error != null) {
          return Center(child: Text("error"));
        }

        // 这里面的数据，就是上面futter的返回数据
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        _moduleList = snapshot.data ?? [];

        return GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10.0),
            itemCount: _moduleList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 20.0,
                mainAxisSpacing: 20.0,
                childAspectRatio: 1.5),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print("${index}");
                  Navigator.of(context).pushNamed(SZFoodListPage.routeName,
                      arguments: _moduleList[index]);
                },
                child: ModuleCellWidget(_moduleList[index]),
              );
            });
      },
    );
  }
}

////////////////////////////////////////////////////////////
// item cell
////////////////////////////////////////////////////////////
class ModuleCellWidget extends StatelessWidget {
  final SZHomeModule _moduleInfo;
  ModuleCellWidget(this._moduleInfo);

  @override
  Widget build(BuildContext context) {
    Color bgColor = _moduleInfo.realColor;
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          gradient:
              LinearGradient(colors: [bgColor.withOpacity(0.5), bgColor])),
      child: Center(
        child: Text(
          _moduleInfo.title ?? "",
          style: TextStyle(fontSize: SZAppThemes.fontNormal),
        ),
      ),
    );
  }
}
