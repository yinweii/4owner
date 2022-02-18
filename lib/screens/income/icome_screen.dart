import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/screens/income/components/char_view.dart';
import 'package:provider/src/provider.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({Key? key}) : super(key: key);

  @override
  _IncomeScreenState createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Invoice>().getAllInvoice(isPay: true);
  }

  DateTime dateSelect = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Khoản thu',
          style: AppTextStyles.defaultBoldAppBar,
        ),
      ),
      body: PieChartView(),
    );
  }
}
