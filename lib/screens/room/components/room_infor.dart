import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_text.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

class RoomInfor extends StatefulWidget {
  final String? roomId;
  const RoomInfor({Key? key, this.roomId}) : super(key: key);

  @override
  _RoomInforState createState() => _RoomInforState();
}

class _RoomInforState extends State<RoomInfor> {
  @override
  Widget build(BuildContext context) {
    var roomData =
        context.read<RoomProvider>().findRoomById(widget.roomId ?? '');
    return Column(
      children: [
        Text(
          '${Utils.convertPrice(roomData.price)}',
          style: AppTextStyles.defaultBold,
        ),
        Card(
          color: AppColors.primary,
          child: Column(
            children: [
              _buildRow(lable: 'Diện tích', value: '${roomData.area}'),
              _buildRow(lable: 'Vị trí', value: '${roomData.floorname}'),
              _buildRow(
                  lable: 'Số người tối đa', value: '${roomData.limidperson}'),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildRow({required String lable, required String value}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$lable :',
            style: AppTextStyles.defaultBold.copyWith(color: AppColors.white),
          ),
          Text(
            value,
            style: AppTextStyles.defaultBold.copyWith(color: AppColors.white2),
          ),
        ],
      ),
    );
  }
}
