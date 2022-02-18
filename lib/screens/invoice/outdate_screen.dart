import 'package:flutter/material.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

import 'components/invoice_item.dart';

class OutDateScreen extends StatefulWidget {
  const OutDateScreen({Key? key}) : super(key: key);

  @override
  _OutDateScreenState createState() => _OutDateScreenState();
}

class _OutDateScreenState extends State<OutDateScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Invoice>().getAllInvoice();
  }

  @override
  Widget build(BuildContext context) {
    final listInvoice = context.read<Invoice>().invoidceOutdate();
    return context.watch<Invoice>().showLoading
        ? Center(
            child: circularProgress(),
          )
        : listInvoice.isEmpty
            ? Center(
                child: Text('Không có dữ liệu'),
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
