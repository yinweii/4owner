import 'package:flutter/material.dart';
import 'package:owner_app/screens/invoice/components/add_invoice_screen.dart';
import 'package:owner_app/utils/utils.dart';

class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({Key? key}) : super(key: key);

  @override
  _InvoiceScreenState createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hợp đồng'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          automaticIndicatorColorAdjustment: true,
          controller: controller,
          tabs: <Tab>[
            Tab(
              text: 'Chưa thanh toán',
            ),
            Tab(
              text: 'Quá hạn',
            ),
            Tab(
              text: 'Đã thanh toán',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          Container(),
          Container(),
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Utils.navigatePage(context, AddInvoice()),
        child: Icon(Icons.add),
      ),
    );
  }
}
