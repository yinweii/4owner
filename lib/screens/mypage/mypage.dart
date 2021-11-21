import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/screens/floor/floor_screen.dart';
import 'package:owner_app/screens/home/home_screen.dart';
import 'package:owner_app/screens/income/icome_screen.dart';
import 'package:owner_app/screens/manager/manager_screen.dart';

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
    const ManagerScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: AppColors.yellow,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_outlined), label: 'Phòng'),
            BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet_outlined),
                label: 'Thu chi'),
            BottomNavigationBarItem(
                icon: Icon(Icons.business_center_outlined), label: 'Quản lý')
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          return tabs[index];
        },
      ),
    );
  }
}
