import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
