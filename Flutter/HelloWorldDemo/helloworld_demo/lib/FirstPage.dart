import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class FirstListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Center(
        child: new FirstListView(),
      ),
    );
  }
}

class FirstListView extends StatefulWidget {
  @override
  _FirstListPageState createState() => new _FirstListPageState();
}

class _FirstListPageState extends State<FirstListView> {
  static const String tailSlogan = 'no more loading';

  var datasourceList = <String>[tailSlogan];

  void _datasourceLoadingHandler() {
    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        datasourceList.insertAll(
            datasourceList.length - 1,
            generateWordPairs()
                .take(20)
                .map((e) => '# ' + e.asPascalCase)
                .toList());
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _datasourceLoadingHandler();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (tailSlogan == datasourceList[index]) {
            if (datasourceList.length < 100) {
              _datasourceLoadingHandler();
              return Container(
                padding: const EdgeInsets.all(16.0),
                alignment: Alignment.center,
                child: SizedBox(
                  width: 24.0,
                  height: 24.0,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                  ),
                ),
              );
            } else {
              return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "没有更多了",
                    style: TextStyle(color: Colors.grey),
                  ));
            }
          } else {
            return new ListCell(datasourceList[index]);
            // return TextButton(
            //     onPressed: () => {
            //           print('click item at $index'),
            //         },
            //     child: ListTile(title: Text(datasourceList[index])));
          }
        },
        separatorBuilder: (context, index) => Divider(
              height: .0,
            ),
        itemCount: datasourceList.length);
  }
}

// ignore: must_be_immutable
class ListCell extends StatelessWidget {
  String title = '';
  ListCell(title) {
    this.title = title;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.grey,
        padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
        height: 80, // cell的高度
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                color: Colors.green,
                child: UserAvatar(
                    'name', 'resources/bg_ugc_uploadMaterial_btn_shadow.png')),
            Container(
                margin: EdgeInsets.fromLTRB(15, 0, 0, 0),
                color: Colors.orange,
                child: Text(this.title))
          ],
        ),
      ),
      onTap: () => {print(this.title)},
    );
  }
}

class UserAvatar extends StatelessWidget {
  String name = '';
  String defaultAvatar = '';
  UserAvatar(this.name, this.defaultAvatar);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          child: CircleAvatar(
            radius: 25.0,
            backgroundImage: AssetImage(this.defaultAvatar),
          ),
        ),
        Text('$name')
      ],
    );
  }
}

class SimpleScrollPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleScrollView'),
      ),
      body: Center(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Center(
                child: Column(
                  children: letters
                      .split('')
                      .map((e) => Text(
                            e,
                            textScaleFactor: 2.0,
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FirstPage'),
      ),
      body: Center(
        child: Text(
          'Welcome to first page!',
          textAlign: TextAlign.left, // 对齐方式
          maxLines: 1, // 最大行数
          overflow: TextOverflow.ellipsis, // 截断方式
          textScaleFactor: 1.5, // 当前字体大小的缩放因子
          style: TextStyle(
              //用于指定文本显示的样式如颜色、字体、粗细、背景等。
              color: Colors.blue,
              fontSize: 18.0,
              height: 1.2,
              fontFamily: "Courier",
              background: new Paint()..color = Colors.yellow,
              decoration: TextDecoration.underline,
              decorationStyle: TextDecorationStyle.dashed),
        ),
      ),
    );
  }
}
