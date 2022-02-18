import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/screens/invoice/components/add_invoice_screen.dart';
import 'package:owner_app/screens/invoice/payment_screen.dart';
import 'package:owner_app/utils/utils.dart';

import 'outdate_screen.dart';
import 'unpayment_screen.dart';

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
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hóa đơn'),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            Tab(
              text: 'Chưa thanh toán',
            ),
            Tab(
              text: 'Quá hạn trả',
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
          UnPaymentScreen(),
          OutDateScreen(),
          PaymentScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddInvoice())),
        child: Icon(Icons.add),
      ),
    );
  }
}
