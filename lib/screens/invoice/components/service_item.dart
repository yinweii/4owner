import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// class ServiceItem extends StatefulWidget {
//   const ServiceItem({Key? key}) : super(key: key);

//   @override
//   _ServiceItemState createState() => _ServiceItemState();
// }

// class _ServiceItemState extends State<ServiceItem> {
//   //Electricity controller
//   TextEditingController _controllerElectLast = TextEditingController();
//   TextEditingController _controllerElectCurent = TextEditingController();
//   TextEditingController _controllerElectPrice = TextEditingController();

//   //water
//   TextEditingController _controllerWaterLast = TextEditingController();
//   TextEditingController _controllerWaterCurent = TextEditingController();
//   TextEditingController _controllerWaterPrice = TextEditingController();

//   double? amount;
//   double? amountWater;

//   @override
//   void initState() {
//     super.initState();
//     //add listener eclectric controller
//     _controllerElectLast.addListener(_totalElectric);
//     _controllerElectCurent.addListener(_totalElectric);
//     _controllerElectPrice.addListener(_totalElectric);

//     //add listener water controller
//     _controllerWaterLast.addListener(_amountWater);
//     _controllerWaterCurent.addListener(_amountWater);
//     _controllerWaterPrice.addListener(_amountWater);
//   }

//   void _amountWater() {
//     var last = _controllerWaterLast.text;
//     var current = _controllerWaterCurent.text;
//     var price = _controllerWaterPrice.text;
//     amountWater =
//         (double.parse(current) - double.parse(last)) * double.parse(price);
//   }

//   void _totalElectric() {
//     var last = _controllerElectLast.text;
//     var current = _controllerElectCurent.text;
//     var price = _controllerElectPrice.text;
//     amount = (double.parse(current) - double.parse(last)) * double.parse(price);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controllerElectLast.dispose();
//     _controllerElectCurent.dispose();
//     _controllerElectPrice.dispose();

//     //disponse
//     _controllerWaterLast.dispose();
//     _controllerWaterCurent.dispose();
//     _controllerWaterPrice.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         BuildCard(
//           controllerLast: _controllerElectLast,
//           controllerCurent: _controllerElectCurent,
//           controllerPrice: _controllerElectPrice,
//           amount: amount,
//           name: 'Điện',
//         ),
//         BuildCard(
//           controllerLast: _controllerWaterLast,
//           controllerCurent: _controllerWaterCurent,
//           controllerPrice: _controllerWaterPrice,
//           amount: amountWater,
//           name: 'Nước',
//         ),
//       ],
//     );
//   }
// }

class BuildCard extends StatelessWidget {
  const BuildCard({
    Key? key,
    required TextEditingController controllerLast,
    required TextEditingController controllerCurent,
    required TextEditingController controllerPrice,
    required this.amount,
    required this.name,
  })  : _controllerElectLast = controllerLast,
        _controllerElectCurent = controllerCurent,
        _controllerElectPrice = controllerPrice,
        super(key: key);

  final TextEditingController _controllerElectLast;
  final TextEditingController _controllerElectCurent;
  final TextEditingController _controllerElectPrice;
  final double? amount;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name),
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
            Text(
              'Thành tiền: ${amount ?? 0}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
