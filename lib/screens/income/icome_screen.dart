import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';
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
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    dateSelect =
                        DateTime(dateSelect.year, dateSelect.month - 1);

                    ;
                  });
                },
                icon: Icon(Icons.arrow_back),
              ),
              Text(
                '${DateFormat('MM-yyyy').format(dateSelect)}',
                style: AppTextStyles.defaultBold,
              ),
              IconButton(
                onPressed: _onCheckNext(dateSelect)
                    ? () {
                        setState(
                          () {
                            dateSelect =
                                DateTime(dateSelect.year, dateSelect.month + 1);
                            ;
                          },
                        );
                      }
                    : null,
                icon: Icon(Icons.arrow_forward),
              ),
            ],
          ),
          PieChartView(selectDate: dateSelect),
        ],
      ),
    );
  }

  bool _onCheckNext(DateTime currentDate) {
    if (DateFormat('MM-yyyy')
        .format(currentDate)
        .contains(DateFormat('MM-yyyy').format(DateTime.now()))) {
      return false;
    }
    return true;
  }
}
