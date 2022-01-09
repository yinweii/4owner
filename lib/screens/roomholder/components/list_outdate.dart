import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/screens/roomholder/components/hold_item.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ListHolderOut extends StatefulWidget {
  const ListHolderOut({Key? key}) : super(key: key);

  @override
  _ListHolderOutState createState() => _ListHolderOutState();
}

class _ListHolderOutState extends State<ListHolderOut> {
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
              var list = customerData.getHolderOutdate();

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
