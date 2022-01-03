import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/screens/invoice/components/update_invoice_screen.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

class InvoiceItem extends StatelessWidget {
  const InvoiceItem(
      {Key? key,
      this.id,
      this.customer,
      this.roomName,
      this.roomCost,
      this.serviceCost,
      this.discount,
      this.total})
      : super(key: key);
  final String? id;
  final String? customer;
  final String? roomName;

  final String? roomCost;
  final String? serviceCost;
  final String? discount;
  final String? total;

  @override
  Widget build(BuildContext context) {
    void _onTapItem() {
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
                Utils.navigatePage(context, UpdateInvoiceScreen(idInvoice: id));
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Thanh toán'),
              onPressed: () {
                context.read<Invoice>().updateStatus(id);
                Navigator.pop(context);
                //Utils.navigatePage(context, EditRoomScreen(id: id));
              },
            ),
            CupertinoActionSheetAction(
              child: const Text('Xoá'),
              onPressed: () {
                //TODO (lam sau):
                //context.read<RoomProvider>().deleteRoom(id!);
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

    return GestureDetector(
      onTap: _onTapItem,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            _buildRow("#${id ?? ''}", total ?? '', Colors.red),
            Row(
              children: [
                Icon(Icons.person),
                Text("${customer ?? ''} | ${roomName ?? ''}"),
              ],
            ),
            _buildRow('Tien phong', roomCost ?? '', Colors.black),
            _buildRow('Tien dich vu', serviceCost ?? '', Colors.black),
            _buildRow('Giam gia', "-${discount ?? ''}", Colors.red),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String title, String price, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 15),
          ),
          Text(
            '$price đ',
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
