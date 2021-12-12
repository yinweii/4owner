import 'package:flutter/material.dart';

class CustomerCard extends StatelessWidget {
  const CustomerCard(
      {Key? key, this.name, this.phoneNumber, this.floorName, this.roomNumber})
      : super(key: key);
  final String? name;
  final String? phoneNumber;
  final String? floorName;
  final String? roomNumber;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, right: 6, bottom: 8),
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
          subtitle: Text("$roomNumber - $floorName"),
          trailing: Text(
            '$phoneNumber',
            style: TextStyle(color: Colors.green),
          ),
        ),
      ),
    );
  }
}
