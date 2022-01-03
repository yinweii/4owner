import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/screens/invoice/components/invoice_item.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class UnPaymentScreen extends StatefulWidget {
  const UnPaymentScreen({Key? key}) : super(key: key);

  @override
  _UnPaymentScreenState createState() => _UnPaymentScreenState();
}

class _UnPaymentScreenState extends State<UnPaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Invoice>().getAllInvoice();
  }

  @override
  Widget build(BuildContext context) {
    final listInvoice = context.watch<Invoice>().invoiceList;
    return context.watch<Invoice>().showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : listInvoice.isNotEmpty
            ? ListView.builder(
                itemCount: listInvoice.length,
                itemBuilder: (ctx, index) => InvoiceItem(
                  id: listInvoice[index].id,
                  customer: listInvoice[index].name,
                  roomName: listInvoice[index].roomName,
                  roomCost: Utils.convertPrice(listInvoice[index].roomCost),
                  serviceCost:
                      Utils.convertPrice(listInvoice[index].priceMoreService),
                  discount: Utils.convertPrice(listInvoice[index].discount),
                  total: Utils.convertPrice(listInvoice[index].totalAmount),
                ),
              )
            : Center(
                child: Text('khong co hop dong ano'),
              );
  }
}
