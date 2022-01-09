import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/two_buttons.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/model/room_holder.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

import 'create_contract.dart';

class DetailHolderScreen extends StatefulWidget {
  final String? id;
  const DetailHolderScreen({Key? key, this.id}) : super(key: key);

  @override
  _DetailHolderScreenState createState() => _DetailHolderScreenState();
}

class _DetailHolderScreenState extends State<DetailHolderScreen> {
  RoomHolderModel? _roomHolderModel;
  @override
  void initState() {
    super.initState();
    _roomHolderModel =
        context.read<RoomHolder>().findHolderById(widget.id ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _roomHolderModel?.customerName ?? '',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Divider(thickness: 1),
              Text(
                "Phòng: ${_roomHolderModel?.roomNumber} | ${_roomHolderModel?.floorNumber} ",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Divider(thickness: 1),
              _buildRow('Ngày vào ở:',
                  '${DateFormat('dd-MM-yyyy').format(_roomHolderModel!.startTime!)}'),
              Divider(thickness: 1),
              _buildRow(
                  'Tiền cọc: ${Utils.convertPrice(_roomHolderModel?.depositCost)}',
                  '${_roomHolderModel?.payment} '),
              Divider(thickness: 1),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TwoButtonsFooter(
          leftButtonLabel: 'Hủy bỏ',
          rightButtonLabel: 'Tạo hợp đồng',
          leftButtonColor: Colors.grey,
          onLeftButtonPressed: () async {
            await context
                .read<RoomHolder>()
                .updateStatus(widget.id ?? '', Constants.holder_cancel);
            await context
                .read<Customer>()
                .updateHolder(_roomHolderModel?.customerId ?? '');
            Navigator.pop(context);
          },
          rightButtonColor: Colors.green,
          onRightButtonPressed: () => Utils.navigatePage(
              context, CreateContractScreen(id: widget.id ?? '')),
        ),
      ),
    );
  }

  _buildRow(String? title, String? desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          Text(
            desc ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
