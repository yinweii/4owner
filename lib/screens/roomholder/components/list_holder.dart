import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';

import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/screens/roomholder/components/hold_item.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class ListHolder extends StatefulWidget {
  const ListHolder({Key? key}) : super(key: key);

  @override
  _ListHolderState createState() => _ListHolderState();
}

class _ListHolderState extends State<ListHolder> {
  @override
  Widget build(BuildContext context) {
    return context.watch<RoomHolder>().showLoading
        ? Center(
            child: circularProgress(),
          )
        : Consumer<RoomHolder>(
            builder: (ctx, customerData, _) {
              // List<RoomHolderModel> temp;
              // if (widget.type == 1) {
              //   temp = customerData.customerHas();
              // } else if (widget.type == 2) {
              //   temp = customerData.customerDeposit();
              // } else {
              //   temp = customerData.customerOut();
              // }

              return customerData.listHolde.length == 0
                  ? Center(child: Text('Không có dữ liệu'))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: customerData.listHolde.length,
                      itemBuilder: (context, index) {
                        return HolderItem(
                          name: customerData.listHolde[index].customerName,
                          roomName: customerData.listHolde[index].roomNumber,
                          floorName: customerData.listHolde[index].floorNumber,
                          number: customerData.listHolde[index].depositCost,
                          dateTime: DateFormat('dd-MM-yyyy')
                              .format(customerData.listHolde[index].startTime!),
                        );
                      },
                    );
            },
          );
  }
}
