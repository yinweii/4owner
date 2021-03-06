import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/components/footer_button.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/utils/diaglog_util.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'edit_customer.dart';

class CustomerDetail extends StatelessWidget {
  final String? id;
  const CustomerDetail({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //make a phone call
    void _launchUrl(String phone) async {
      String url = 'tel:' + phone;
      if (await canLaunch(url)) {
        launch(url);
      } else {
        throw "Could not launch $url";
      }
    }

    var _customer = context.read<Customer>().getCustomerByID(id ?? '');

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () =>
                Utils.navigatePage(context, EditCustomerScreen(id: id ?? '')),
            icon: Icon(Icons.border_color),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Card(
              child: Stack(
                children: [
                  Container(
                    width: Utils.sizeWidth(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 45,
                            child: Icon(Icons.account_circle_outlined),
                          ),
                          SizedBox(height: 15),
                          Text(
                            '${_customer.name ?? ''}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 5,
                    right: 20,
                    child: IconButton(
                      onPressed: () => _launchUrl(_customer.phonenumber ?? ''),
                      icon: Icon(
                        Icons.phone_forwarded_rounded,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Card(
                child: Container(
                  width: Utils.sizeWidth(context),
                  child: Column(
                    children: [
                      _buildRow('Email: ', '${_customer.email}'),
                      Divider(),
                      _buildRow('S??? ??i???n tho???i: ', '${_customer.phonenumber}'),
                      Divider(),
                      _buildRow('CMND/CCCD', '${_customer.cardnumber}'),
                      Divider(),
                      _buildRow('Ph??ng',
                          '${_customer.roomnumber} | ${_customer.floornumber}'),
                      Divider(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 6, horizontal: 8),
                        child: Container(
                          width: Utils.sizeWidth(context),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '?????a ch???: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w700),
                              ),
                              SizedBox(width: 10),
                              Flexible(
                                child: Text(
                                  '${_customer.address}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
        child: FooterButton(
          buttonColor: AppColors.red,
          label: 'X??a',
          onPressed: () => DialogUtil.cupertioDialog(
            context: context,
            title: 'X??a',
            content: 'B???n ch???c ch???n mu???n x??a',
            yesAction: () =>
                context.read<Customer>().deleteCustomer(id ?? '').then(
              (value) {
                context.read<Customer>().onRefesh();
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  _buildRow(String? title, String? desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
          Text(
            desc ?? '',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
