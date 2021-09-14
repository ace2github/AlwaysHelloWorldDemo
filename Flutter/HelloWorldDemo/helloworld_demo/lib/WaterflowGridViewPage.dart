import 'package:flutter/material.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// 使用第三方组件：flutter_staggered_grid_view
/// https://pub.dev/packages/flutter_staggered_grid_view/example
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