import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';

import 'package:owner_app/screens/roomholder/components/list_outdate.dart';
import 'package:owner_app/utils/utils.dart';

import 'add_holder_screen.dart';
import 'components/list_holder.dart';

class HoldRoomScreen extends StatefulWidget {
  const HoldRoomScreen({Key? key}) : super(key: key);

  @override
  _HoldRoomScreenState createState() => _HoldRoomScreenState();
}

class _HoldRoomScreenState extends State<HoldRoomScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.red,
          automaticIndicatorColorAdjustment: true,
          controller: controller,
          tabs: <Tab>[
            Tab(
              text: 'Chờ phòng',
            ),
            Tab(
              text: 'Quá hạn',
            ),
            Tab(
              text: 'Đã hủy',
            ),
            Tab(
              text: 'Đã tạo hợp đồng',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: [
          ListHolder(type: 1),
          ListHolderOut(),
          ListHolder(type: 2),
          ListHolder(type: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Utils.navigatePage(context, AddHoldScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
