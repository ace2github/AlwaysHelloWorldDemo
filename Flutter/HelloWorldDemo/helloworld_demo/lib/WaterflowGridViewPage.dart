import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 使用第三方组件：flutter_staggered_grid_view
/// https://pub.dev/packages/flutter_staggered_grid_view/example
/// 使用插件flutter_staggered_grid_view实现分页瀑布流效果 https://www.keppel.fun/articles/2019/04/26/1556245200876.html
/// flutter_staggered_grid_view和瀑布流效果 https://juejin.cn/post/6844904168847573006
/// flutter_staggered_grid_view和瀑布流效果 https://juejin.cn/post/6844903949317718030
/// https://zhuanlan.zhihu.com/p/160869337
///
class WaterFlowGridPage extends StatelessWidget {
  const WaterFlowGridPage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Water flow view'),),
      body: WaterFlowListView(),
    );
  }
}

class WaterFlowListView extends StatefulWidget {
  const WaterFlowListView({ Key? key }) : super(key: key);

  @override
  _WaterFlowListViewState createState() => _WaterFlowListViewState();
}

class _WaterFlowListViewState extends State<WaterFlowListView> {
 @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

// class _WaterFlowListViewState extends State<WaterFlowListView> {
//   @override
//   Widget build(BuildContext context) {
//     return StaggeredGridView.countBuilder(
//       crossAxisCount: 4,
//       itemCount: 8,
//       itemBuilder: (BuildContext context, int index) => new Container(
//           color: Colors.green,
//           child: new Center(
//             child: new CircleAvatar(
//               backgroundColor: Colors.white,
//               child: new Text('$index'),
//             ),
//           )),
//       staggeredTileBuilder: (int index) =>
//           new StaggeredTile.count(2, index.isEven ? 2 : 1),
//       mainAxisSpacing: 4.0,
//       crossAxisSpacing: 4.0,
//     );
//   }
// }