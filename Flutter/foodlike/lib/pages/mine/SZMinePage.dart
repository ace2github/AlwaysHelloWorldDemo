import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/pages/mine/SZSettingPage.dart';

class SZMinePage extends StatelessWidget {
  static final String routeName = "/mine";
  const SZMinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MineMainView(),
    );
  }
}

///////////////////////////////////////////////////////////////////////
///
class MineMainView extends StatefulWidget {
  const MineMainView({super.key});

  @override
  State<MineMainView> createState() => _MineMainViewState();
}

class _MineMainViewState extends State<MineMainView> {
  final _iconList = [
    Icons.ac_unit,
    Icons.airplane_ticket,
    Icons.all_inclusive,
    Icons.beach_access,
    Icons.cake,
    Icons.free_breakfast
  ];
  @override
  Widget build(BuildContext context) {
    List<String> settingList = [
      "个人资料",
      "订单",
      "评价",
      "设置",
    ];
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 160.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Row(children: [
              UserAvatar(
                url: "https://picsum.photos/200/300?random=888",
                size: 50,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text("陈朝晖"),
              )
            ]),
            background: Image.asset(
              "assets/images//banner_bg.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          childCount: settingList.length,
          (context, index) {
            return Container(
              height: 50,
              child: ListTile(
                title: Row(
                  children: [
                    Icon(_iconList[index % (_iconList.length)]),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      "${settingList[index]}",
                      textAlign: TextAlign.left,
                    )
                  ],
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 15,
                ),
                onTap: () {
                  print("click ${index}");
                  switch (index) {
                    case 0:
                      Navigator.of(context).pushNamed(SZSettingPage.routeName);
                      break;
                    default:
                  }
                },
              ),
            );
          },
        ))
      ],
    );
  }
}

class UserAvatar extends StatelessWidget {
  String url = '';
  double size = 40.0;
  UserAvatar({super.key, required this.url, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(size)),
      child: Image.network(
        url,
        fit: BoxFit.cover,
      ),
    );
  }
}
