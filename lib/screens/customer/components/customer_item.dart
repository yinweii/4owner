import 'package:flutter/material.dart';
import 'package:owner_app/utils/utils.dart';

import '../customer_detail.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key,
      this.id,
      this.name,
      this.phoneNumber,
      this.floorName,
      this.roomNumber})
      : super(key: key);
  final String? id;
  final String? name;
  final String? phoneNumber;
  final String? floorName;
  final String? roomNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 6),
      child: GestureDetector(
        onTap: () => Utils.navigatePage(context, CustomerDetail(id: id)),
        child: Card(
          child: Container(
            child: ListTile(
              leading: CircleAvatar(
                radius: 20,
                child: Icon(Icons.account_circle_outlined),
              ),
              title: Text(
                '$name',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              ),
              subtitle: Row(
                children: [
                  Text(
                    "$floorName ",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
                  ),
                  SizedBox(width: 3),
                  Text('$roomNumber',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                ],
              ),
              trailing: Text(
                '$phoneNumber',
                style: TextStyle(color: Colors.green),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
