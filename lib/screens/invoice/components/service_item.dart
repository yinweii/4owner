import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ServiceItem extends StatefulWidget {
  const ServiceItem({Key? key}) : super(key: key);

  @override
  _ServiceItemState createState() => _ServiceItemState();
}

class _ServiceItemState extends State<ServiceItem> {
  bool? isCheck;
  final String? name;
  final double? priceService;
  final String? note;
  final double? amount;

  _ServiceItemState(
      {this.isCheck = false,
      this.name,
      this.priceService,
      this.note,
      this.amount});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Row(
            children: [
              Checkbox(
                value: isCheck,
                onChanged: (value) {
                  setState(() {
                    isCheck = value;
                  });
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
