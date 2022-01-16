import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/screens/floor/floor_screen.dart';
import 'package:owner_app/screens/home/home_screen.dart';
import 'package:owner_app/screens/income/icome_screen.dart';

import 'package:owner_app/screens/orthermenu/orther_screen.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Widget> tabs = [
    const HomeScreen(),
    const FloorScreen(),
    const IncomeScreen(),
    const OtherMenuScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: AppColors.yellowFFE5D26A,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_outlined), label: 'Phòng'),
            BottomNavigationBarItem(
                icon: Icon(Icons.trending_up_outlined), label: 'Thu chi'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Cài đặt')
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          return tabs[index];
        },
      ),
    );
  }
}
