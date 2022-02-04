import 'package:flutter/material.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/screens/customer/components/customer_item.dart';
import 'package:provider/src/provider.dart';

class CustomerInfor extends StatefulWidget {
  final String? roomId;
  const CustomerInfor({Key? key, this.roomId}) : super(key: key);

  @override
  _CustomerInforState createState() => _CustomerInforState();
}

class _CustomerInforState extends State<CustomerInfor> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Customer>().getListCustomer();
  }

  @override
  Widget build(BuildContext context) {
    var listCustomer =
        context.read<Customer>().customerByRoom(widget.roomId ?? '');
    return context.watch<Customer>().showLoading
        ? circularProgress()
        : listCustomer.isEmpty
            ? Center(child: Text('Khong co nguoi thue'))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nguoi thue',
                      style: AppTextStyles.defaultBold,
                    ),
                  ),
                  _buildListCustomer(listCustomer),
                ],
              );
  }

  Widget _buildListCustomer(List<CustomerModel> listCustomer) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        listCustomer.length,
        (index) => CustomerCard(
          id: listCustomer[index].id,
          name: listCustomer[index].name,
          phoneNumber: listCustomer[index].phonenumber,
          floorName: listCustomer[index].floornumber,
          roomNumber: listCustomer[index].roomnumber,
        ),
      ),
    );
  }
}
