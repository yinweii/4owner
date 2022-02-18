import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/screens/income/components/indicator_view.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

var format = NumberFormat("###.0#");

class PieChartView extends StatefulWidget {
  const PieChartView({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => PieChartViewState();
}

class PieChartViewState extends State {
  late DateTime selectDate;
  @override
  void initState() {
    selectDate = DateTime.now();
    super.initState();
    context.read<Invoice>().getAllInvoice(isPay: true);
  }

  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    var data = context.watch<Invoice>();

    String date = DateFormat('MM-yyyy').format(selectDate);
    var total = data.electTotal(date: date) +
        data.waterTotal(date: date) +
        data.roomTotal(date: date) +
        data.moreService(date: date);
    if (context.watch<Invoice>().showLoading) {
      return circularProgress();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        selectDate =
                            DateTime(selectDate.year, selectDate.month - 1);

                        ;
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                  ),
                  Text(
                    '${DateFormat('MM-yyyy').format(selectDate)}',
                    style: AppTextStyles.defaultBold,
                  ),
                  IconButton(
                    onPressed: _onCheckNext(selectDate)
                        ? () {
                            setState(
                              () {
                                selectDate = DateTime(
                                    selectDate.year, selectDate.month + 1);
                                ;
                              },
                            );
                          }
                        : null,
                    icon: Icon(Icons.arrow_forward),
                  ),
                ],
              ),
              AspectRatio(
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
                              sections: showingSections(),
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
              ),
              const SizedBox(
                height: 30,
              ),
              _buildInfor(
                  lable: 'Tiền phòng',
                  value: Utils.convertPrice(data.roomTotal(date: date))),
              Divider(),
              _buildInfor(
                  lable: 'Tiền điện',
                  value: Utils.convertPrice(data.electTotal(date: date))),
              Divider(),
              _buildInfor(
                  lable: 'Tiền ước',
                  value: Utils.convertPrice(data.waterTotal(date: date))),
              Divider(),
              _buildInfor(
                  lable: 'Dịch vụ khác',
                  value: Utils.convertPrice(data.moreService(date: date))),
              Divider(),
              _buildInfor(lable: 'Tổng', value: Utils.convertPrice(total)),
              Divider(),
            ],
          ),
        ),
      );
    }
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 15.0 : 10.0;
      final radius = isTouched ? 60.0 : 50.0;

      var data = context.watch<Invoice>();
      String date = DateFormat('MM-yyyy').format(selectDate);

      double totalAmount = data.electTotal(date: date) +
          data.waterTotal(date: date) +
          data.roomTotal(date: date) +
          data.moreService(date: date);

      double room = double.parse(
          format.format(((data.roomTotal(date: date) / totalAmount) * 100)));

      double water = double.parse(
          format.format(((data.waterTotal(date: date) / totalAmount) * 100)));
      double elect = double.parse(
          format.format(((data.electTotal(date: date) / totalAmount) * 100)));
      double moreService = double.parse(
          format.format(((data.moreService(date: date) / totalAmount) * 100)));

      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: double.parse(format.format(room)),
            title: '${room}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: water,
            title: '${water}%',
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
            title: '${elect}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
                color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: moreService,
            title: '${moreService}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  Widget _buildInfor({String? lable, String? value}) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            lable ?? '',
            style: AppTextStyles.defaultBold,
          ),
          Text(
            value ?? '',
            style: AppTextStyles.defaultBold,
          ),
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
