import 'package:flutter/material.dart';

import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/screens/customer/components/customer_item.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatelessWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final listCustomer = context.watch<Customer>().listCustomer;
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return Divider(
          thickness: 2,
        );
      },
      itemCount: listCustomer.length,
      itemBuilder: (context, index) {
        return CustomerCard(
          name: listCustomer[index].name,
          phoneNumber: listCustomer[index].phoneNumber,
          floorName: listCustomer[index].floorNumber,
          roomNumber: listCustomer[index].roomNumber,
        );
      },
    );
  }
}
