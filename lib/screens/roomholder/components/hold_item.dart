import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/utils/diaglog_util.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

import '../detail_holder_screen.dart';

class HolderItem extends StatelessWidget {
  const HolderItem(
      {Key? key,
      this.id,
      this.name,
      this.number,
      this.roomName,
      this.dateTime,
      this.floorName})
      : super(key: key);
  final String? id;
  final String? name;
  final String? roomName;
  final String? floorName;
  final double? number;
  final String? dateTime;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showPopup(context),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildRow(
                icon: Icon(
                  Icons.person,
                ),
                title: name,
                lastTitle: Utils.convertPrice(number),
                isPerson: true,
              ),
              SizedBox(height: 8),
              _buildRow(
                icon: Icon(Icons.home),
                title: '$floorName | $roomName',
              ),
              SizedBox(height: 8),
              _buildRow(
                icon: Icon(
                  Icons.date_range_outlined,
                ),
                title: 'Hẹn ngày vào',
                lastTitle: dateTime,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildRow(
      {Icon? icon, String? title, String? lastTitle, bool isPerson = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon!,
            SizedBox(width: 15),
            Text(
              title ?? '',
              style: TextStyle(
                fontSize: isPerson ? 18 : 15,
                fontWeight: isPerson ? FontWeight.bold : null,
              ),
            ),
          ],
        ),
        Text(
          lastTitle ?? '',
          style: TextStyle(
              fontSize: isPerson ? 18 : 15,
              fontWeight: FontWeight.bold,
              color: isPerson ? AppColors.greenFF79AF91 : null),
        ),
      ],
    );
  }

  void _showPopup(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            child: const Text('Chi tiết'),
            onPressed: () {
              Navigator.pop(context);
              Utils.navigatePage(context, DetailHolderScreen(id: id));
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Chỉnh sửa'),
            onPressed: () {
              Navigator.pop(context);
              // Utils.navigatePage(context, EditRoomScreen(id: id));
            },
          ),
          CupertinoActionSheetAction(
            child: const Text('Xoá'),
            onPressed: () async {
              context.read<RoomHolder>().deleteHolder(id ?? '').then((value) {
                context.read<RoomHolder>().onRefesh();
              });
              Navigator.pop(context);
            },
          ),
        ],
        cancelButton: CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Huỷ bỏ')),
      ),
    );
  }
}
