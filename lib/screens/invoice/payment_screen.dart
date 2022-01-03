import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

import 'components/invoice_item.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Invoice>().getAllInvoice(isPay: true);
  }

  @override
  Widget build(BuildContext context) {
    final listInvoice = context.watch<Invoice>().invoiceList;
    return context.watch<Invoice>().showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
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
          );
  }
}
