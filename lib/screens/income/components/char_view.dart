import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/screens/income/components/indicator_view.dart';
import 'package:provider/src/provider.dart';

var format = NumberFormat("###.0#");

class PieChartView extends StatefulWidget {
  const PieChartView({Key? key, required this.selectDate}) : super(key: key);
  final DateTime? selectDate;

  @override
  State<StatefulWidget> createState() =>
      PieChartViewState(selectDate: selectDate!);
}

class PieChartViewState extends State {
  late DateTime selectDate;

  PieChartViewState({required this.selectDate});
  @override
  void initState() {
    selectDate = DateTime.now();
    super.initState();
    context.read<Invoice>().getAllInvoice(isPay: true);
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (context.watch<Invoice>().showLoading) {
      return circularProgress();
    } else {
      return AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(touchCallback:
                          (FlTouchEvent event, pieTouchResponse) {
                        setState(() {
                          if (!event.isInterestedForInteractions ||
                              pieTouchResponse == null ||
                              pieTouchResponse.touchedSection == null) {
                            touchedIndex = -1;
                            return;
                          }
                          touchedIndex = pieTouchResponse
                              .touchedSection!.touchedSectionIndex;
                        });
                      }),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 0,
                      centerSpaceRadius: 40,
                      sections: showingSections(selectDate),
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Indicator(
                    color: Color(0xff0293ee),
                    text: 'Tiền phòng',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xfff8b250),
                    text: 'Tiền nước',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff845bef),
                    text: 'Tiền điện',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Indicator(
                    color: Color(0xff13d38e),
                    text: 'Dịch vụ',
                    isSquare: true,
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
              const SizedBox(
                width: 28,
              ),
            ],
          ),
        ),
      );
    }
  }

  List<PieChartSectionData> showingSections(DateTime selectDate) {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      var data = context.read<Invoice>();
      String date = DateFormat('MM-yyyy').format(selectDate);

      double totalAmount = data.electTotal(date) +
          data.waterTotal(date) +
          data.roomTotal(date) +
          data.moreService(date);
      print('TONG: $totalAmount');

      double room = ((data.roomTotal(date) % totalAmount) * 100);
      print(room);
      int water = ((data.waterTotal(date) / totalAmount) * 100).ceil();
      int elect = ((data.electTotal(date) / totalAmount) * 100).ceil();
      double moreService = 100 - (room + water + elect);

      //double value =

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: double.parse(room.toString()),
            title: '${room.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: double.parse(water.toString()),
            title: '${water.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: double.parse(elect.toString()),
            title: '${elect.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: double.parse(moreService.toString()),
            title: '${moreService.ceil()}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
}
