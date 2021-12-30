import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({Key? key}) : super(key: key);

  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  String? name;
  TextEditingController _controllerElectLast = TextEditingController();
  TextEditingController _controllerElectCurent = TextEditingController();
  TextEditingController _controllerElectPrice = TextEditingController();
  TextEditingController _controllerAmount = TextEditingController();
  double? amount;

  // tinh tong

  // double _amountTotal() {
  //   // double tong = (double.parse(_controllerElectCurent.text) -
  //   //         double.parse(_controllerElectCurent.text)) *
  //   //     double.parse(_controllerElectPrice.text);
  //   if (_controllerElectPrice.text.isNotEmpty) {
  //     print('TONG: ${_controllerElectPrice.text}');
  //     return double.parse(_controllerElectPrice.text);
  //   }
  //   return 7;
  // }

  @override
  void initState() {
    super.initState();
    _controllerElectLast.addListener(_amountPrint);
  }

  void _amountPrint() {
    var dd = _controllerElectLast.text;
    print('AMUNT: ${dd}');
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dien'),
            SizedBox(height: 10),
            SizedBox(
              height: 35,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controllerElectLast,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Chỉ số cũ',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controllerElectCurent,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Chỉ số mới',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _controllerElectPrice,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Đơn giá',
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Text('Thành tiền: ${0}')
          ],
        ),
      ),
    );
  }
}
