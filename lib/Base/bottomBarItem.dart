import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pets_app/Base/EventBus.dart';
import 'package:pets_app/Index/Controller/test.dart';


class bottomBatItem extends StatefulWidget {
  final arguments;

  const bottomBatItem({Key key, this.arguments}) : super(key: key);
  @override
  _bottomBatItemState createState() => _bottomBatItemState();
}

class _bottomBatItemState extends State<bottomBatItem> {
  int currentIndex = 0;
  final pageController = PageController();
  @override
  void initState() {
    super.initState();
    bus.on("BottomBarToggle", (object) {
      setState(() {
        currentIndex = object;
        pageController.jumpToPage(currentIndex);
      });
    });
  }

  void onTap(int index) {
    pageController.jumpToPage(index);
    bus.emit('pageController', index);
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }


  @override
  void deactivate() {
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      print('返回主页');
    }
  }

  @override
  void dispose() {
    super.dispose();
    bus.off("BottomBarToggle");
  }

  final pages = [
    StrategicEditPageHedgeViewController(),
    StrategicEditPageHedgeViewController(),
    StrategicEditPageHedgeViewController(),
    StrategicEditPageHedgeViewController(),
    StrategicEditPageHedgeViewController(),
    // PremiumViewController(),
    // StrategicControlViewController(),
    // AssetStatisticsViewController(),
    // SettingViewController(),
    // WalletViewController(),
    // TransactionViewController(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: pageController,
        children: pages,
        onPageChanged: onPageChanged,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.home_filled),
            activeIcon: Icon(Icons.home_filled),
            label: "首页",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.message_rounded),
            activeIcon: Icon(Icons.message_rounded),
            label: "论坛",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.repeat_rounded),
            activeIcon: Icon(Icons.repeat_rounded),
            label: "评测",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.favorite_rounded),
            activeIcon: Icon(Icons.favorite_rounded),
            label: "科普",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.transparent,
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person),
            label: "我的",
          ),
        ],
        currentIndex: currentIndex,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedFontSize :13.0,
        selectedItemColor: Color.fromRGBO(241, 157, 75,1),
        unselectedFontSize : 13.0,
        unselectedItemColor: Colors.grey,
        onTap: onTap,
      ),
    );
  }
}
