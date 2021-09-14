import 'package:flutter/material.dart';

class CustomScrollViewPage extends StatefulWidget {
  const CustomScrollViewPage({ Key? key }) : super(key: key);

  @override
  _CustomScrollViewPageState createState() => _CustomScrollViewPageState();
}

class _CustomScrollViewPageState extends State<CustomScrollViewPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180.0,
            // 实现功能：头部伸缩的模型
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Custom Scroll Page'),
              background: Image.asset('resources/banner_bg.png', fit: BoxFit.cover,),
            ),
          ),

          // banner
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index){
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.cyan[100*(index%9)],
                    child: Text('module $index'),
                  );
                },
                childCount: 16
              ), 
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 单行个数
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1.0
              )),
          ),

          // 列表
          SliverPadding(
            padding: EdgeInsets.fromLTRB(15, 30, 15, 15),
            sliver: SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Container(
                    alignment: Alignment.center,
                    color: Colors.orange[100*(index%9)],
                    child: Text('list cell $index'),
                  );
                },
                childCount: 106
              ), 
              itemExtent: 60,),
          ),
          
        ],
      ),
    );
  }
}
