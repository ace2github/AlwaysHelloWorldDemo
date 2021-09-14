import 'package:flutter/material.dart';

class GridViewpage extends StatelessWidget {
  const GridViewpage({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Grid View Page'),),
      body: Column(
        children: [
          // 外部的宽高必须有值，因此需要嵌入Container中
          Container(height: 150, color: Colors.orange, child: SimpleGridView(),),
          Container(height: 300, color: Colors.lightBlue, child: GridViewBuilderView(),)
        ],
      ),
    );
  }
}

class SimpleGridView extends StatelessWidget {
  const SimpleGridView({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // 横轴子元素的数量
          //mainAxisSpacing: 1, // 主轴方向的间距
          //crossAxisSpacing: 1, // 横轴方向子元素的间距
          childAspectRatio: 2, // 子元素在横轴长度和主轴长度的比例
        ),
        scrollDirection: Axis.vertical,
        children: [
          Icon(Icons.ac_unit),
          Icon(Icons.airplane_ticket),
          Icon(Icons.all_inclusive),
          Icon(Icons.beach_access),
          Icon(Icons.cake),
          Icon(Icons.free_breakfast)
        ],
      );
  }
}


class GridViewBuilderView extends StatefulWidget {
  const GridViewBuilderView({ Key? key }) : super(key: key);

  @override
  _GridViewBuilderViewState createState() => _GridViewBuilderViewState();
}

class _GridViewBuilderViewState extends State<GridViewBuilderView> {
  List<IconData> _gridDataList = [];

  @override
  void initState() {
    _requestGridDataHandler();
    super.initState();
  }

  void _requestGridDataHandler() {
    Future.delayed(Duration(microseconds: 600)).then((value) => {
      // 更新状态
      setState((){
        _gridDataList.addAll([
          Icons.ac_unit,
          Icons.airplane_ticket,
          Icons.all_inclusive,
          Icons.beach_access,
          Icons.cake,
          Icons.free_breakfast 
        ]);
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          childAspectRatio: 1.5
        ),
        
        itemCount: _gridDataList.length,

        itemBuilder: (context, index){
          if (index == _gridDataList.length-1 && _gridDataList.length<180) {
            _requestGridDataHandler();
          }
          
          return Icon(_gridDataList[index]);
        },
      ),
    );
  }
}
