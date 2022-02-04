import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/screens/room/components/customer_infor.dart';
import 'package:owner_app/screens/room/components/room_infor.dart';

class TabCupertinoController extends StatefulWidget {
  final String? roomId;
  const TabCupertinoController({Key? key, this.roomId}) : super(key: key);

  @override
  _TabCupertinoControllerState createState() => _TabCupertinoControllerState();
}

class _TabCupertinoControllerState extends State<TabCupertinoController> {
  int selectedValue = 0;
  Map<int, Widget> children = <int, Widget>{
    0: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "Thông tin",
        style: AppTextStyles.defaultBold,
      ),
    ),
    1: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        "Người thuê",
        style: AppTextStyles.defaultBold,
      ),
    ),
  };
  @override
  Widget build(BuildContext context) {
    List<Widget> listPage = [
      RoomInfor(
        roomId: widget.roomId,
      ),
      CustomerInfor(
        roomId: widget.roomId,
      ),
    ];
    return Column(children: [
      Container(
        width: double.infinity,
        child: CupertinoSegmentedControl(
          children: children,
          onValueChanged: (int value) {
            selectedValue = value;
            setState(() {});
          },
          selectedColor: AppColors.primary,
          unselectedColor: CupertinoColors.systemGrey5,
          borderColor: CupertinoColors.tertiarySystemBackground,
          pressedColor: AppColors.primary,
          groupValue: selectedValue,
        ),
      ),
      SizedBox(
        height: 8,
      ),
      Container(
        height: 500,
        width: double.infinity,
        child: listPage[selectedValue],
      )
    ]);
  }
}
