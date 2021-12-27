import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/screens/contract/components/edit_contract_screen.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

class ContractItem extends StatelessWidget {
  const ContractItem(
      {Key? key,
      this.id,
      this.roomNumber,
      this.floorNumber,
      this.dateFrom,
      this.dateTo,
      this.customerName})
      : super(key: key);
  final String? id;
  final String? roomNumber;
  final String? floorNumber;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? customerName;

  //on tap item

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('Chi tiết'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Chỉnh sửa'),
                onPressed: () {
                  Navigator.pop(context);
                  Utils.navigatePage(context, EditContractScreen(id: id));
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Xoá'),
                onPressed: () {
                  context
                      .read<Contract>()
                      .deleteContract(id ?? '')
                      .then((value) => Navigator.pop(context));
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
      },
      child: Container(
        height: 150,
        width: Utils.sizeWidth(context),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "# $id",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home_work_outlined,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "$floorNumber-$roomNumber",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(dateFrom!)} Đến ${dateTo != null ? DateFormat('dd-MM-yyyy').format(dateTo!) : '[Không xác định]'}",
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_outlined,
                    ),
                    SizedBox(width: 5),
                    Text('$customerName')
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
