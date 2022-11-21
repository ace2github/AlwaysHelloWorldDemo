import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:foodlike/pages/main/SZMainInitializes.dart';

import '../home/SZDrawerWidget.dart';

class SZMainPage extends StatefulWidget {
  static const String routeName = "/";
  const SZMainPage({super.key});

  @override
  State<SZMainPage> createState() => _SZMainPageState();
}

class _SZMainPageState extends State<SZMainPage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SZDrawerMain(),
      body: IndexedStack(
        index: _currentIndex,
        children: tabPages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: tabItems,
        // selectedFontSize: 14,
        // unselectedFontSize: 14,
        onTap: (selIndex) {
          setState(() {
            _currentIndex = selIndex;
          });
        },
      ),
    );
  }
}
