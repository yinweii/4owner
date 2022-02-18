import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/model/contract_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/screens/contract/components/contract_item.dart';

class ListContract extends StatefulWidget {
  const ListContract({
    Key? key,
    required this.type,
    required this.typeItem,
  }) : super(key: key);
  final int type;
  final int typeItem;

  @override
  _ListContractState createState() => _ListContractState();
}

class _ListContractState extends State<ListContract> {
  @override
  void initState() {
    super.initState();
    context.read<Contract>().getAllContract();
    context.read<Customer>().getListCustomer();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<Contract>().showLoading
        ? Center(
            child: circularProgress(),
          )
        : Consumer<Contract>(
            builder: (ctx, customerData, _) {
              List<ContractModel> list = [];
              int? typeItem;
              if (widget.type == 1) {
                typeItem = 1;
                list = customerData.listContractActivity(
                    status: false, isActive: true);
              } else if (widget.type == 2) {
                typeItem = 2;
                list = customerData.listContractOut();
              } else {
                typeItem = 3;
                list = list = customerData.listContractActivity(
                    status: true, isActive: true);
              }

              return list.length == 0
                  ? Center(child: Text('Không có dữ liệu'))
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 2,
                        );
                      },
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        var customer = context
                            .read<Customer>()
                            .getCustomerByID(list[index].idCustomer ?? '');

                        return ContractItem(
                          typeItem: typeItem!,
                          id: list[index].id,
                          floorNumber: customer.floornumber,
                          roomNumber: customer.roomnumber,
                          dateFrom: list[index].dateFrom ?? DateTime.now(),
                          dateTo: list[index].dateTo ?? DateTime.now(),
                          customerName: customer.name,
                          customerId: list[index].idCustomer,
                        );
                      },
                    );
            },
          );
  }
}
