import 'package:flutter/material.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:provider/provider.dart';

import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/screens/customer/components/customer_item.dart';

class CustomerList extends StatefulWidget {
  const CustomerList({
    Key? key,
    this.type,
  }) : super(key: key);
  final int? type;

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
            child: circularProgress(),
          )
        : Consumer<Customer>(
            builder: (ctx, customerData, _) {
              List<CustomerModel> temp;
              if (widget.type == 1) {
                temp = customerData.customerHas();
              } else if (widget.type == 2) {
                temp = customerData.customerDeposit();
              } else {
                temp = customerData.customerOut();
              }

              return temp.length == 0
                  ? Center(child: Text('Không có dữ liệu'))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: temp.length,
                      itemBuilder: (context, index) {
                        return CustomerCard(
                          name: temp[index].name,
                          phoneNumber: temp[index].phoneNumber,
                          floorName: temp[index].floorNumber,
                          roomNumber: temp[index].roomNumber,
                        );
                      },
                    );
            },
          );
  }
}
