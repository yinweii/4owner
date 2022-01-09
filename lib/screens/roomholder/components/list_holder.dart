import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/model/room_holder.dart';

import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/screens/roomholder/components/hold_item.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ListHolder extends StatefulWidget {
  final int type;
  const ListHolder({Key? key, required this.type}) : super(key: key);

  @override
  _ListHolderState createState() => _ListHolderState();
}

class _ListHolderState extends State<ListHolder> {
  @override
  void initState() {
    super.initState();
    context.read<RoomHolder>().getHolder();
    context.read<RoomHolder>().getHolderOutdate();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<RoomHolder>().showLoading
        ? Center(
            child: circularProgress(),
          )
        : Consumer<RoomHolder>(
            builder: (ctx, customerData, _) {
              String mapType = '';
              if (widget.type == 1) {
                mapType = Constants.holder_waitting;
              } else if (widget.type == 2) {
                mapType = Constants.holder_cancel;
              } else {
                mapType = Constants.holder_readly;
              }
              List<RoomHolderModel> list = [];
              if (mapType == Constants.holder_cancel) {
                list = customerData.getHolderByStatus(
                    status: mapType, isCancel: true);
              } else {
                list = customerData.getHolderByStatus(status: mapType);
              }

              return list.length == 0
                  ? Center(child: Text('Không có dữ liệu'))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return HolderItem(
                          id: list[index].id,
                          name: list[index].customerName,
                          roomName: list[index].roomNumber,
                          floorName: list[index].floorNumber,
                          number: list[index].depositCost,
                          dateTime: DateFormat('dd-MM-yyyy')
                              .format(list[index].startTime!),
                        );
                      },
                    );
            },
          );
  }
}
