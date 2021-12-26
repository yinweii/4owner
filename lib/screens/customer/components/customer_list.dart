import 'package:flutter/material.dart';

import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/screens/customer/components/customer_item.dart';
import 'package:provider/provider.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({Key? key}) : super(key: key);

  @override
  State<CustomerList> createState() => _CustomerListState();
}

class _CustomerListState extends State<CustomerList> {
  @override
  void initState() {
    super.initState();
    context.read<Customer>().getListCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<Customer>().showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Consumer<Customer>(
            builder: (ctx, customerData, _) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              separatorBuilder: (context, index) {
                return Divider(
                  thickness: 2,
                );
              },
              itemCount: customerData.listCustomer.length,
              itemBuilder: (context, index) {
                return CustomerCard(
                  name: customerData.listCustomer[index].name,
                  phoneNumber: customerData.listCustomer[index].phoneNumber,
                  floorName: customerData.listCustomer[index].floorNumber,
                  roomNumber: customerData.listCustomer[index].roomNumber,
                );
              },
            ),
          );
  }
}
