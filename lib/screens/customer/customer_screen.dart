import 'package:flutter/material.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/utils/utils.dart';

import 'add_customer_screen.dart';
import 'components/customer_list.dart';
import 'package:provider/provider.dart';

class IndentureScreen extends StatefulWidget {
  const IndentureScreen({Key? key}) : super(key: key);

  @override
  _IndentureScreenState createState() => _IndentureScreenState();
}

class _IndentureScreenState extends State<IndentureScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
    context.read<Customer>().getListCustomer();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Người thuê'),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            Tab(
              child: _buildLable(
                  title: 'Đã có phòng',
                  number: '${context.watch<Customer>().customerHas().length}'),
            ),
            Tab(
              child: _buildLable(
                  title: 'Chưa có phòng',
                  number:
                      '${context.watch<Customer>().customerDeposit().length}'),
            ),
            Tab(
              child: _buildLable(
                  title: 'Đã thanh lý',
                  number: '${context.watch<Customer>().customerOut().length}'),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          CustomerList(type: 1),
          CustomerList(type: 2),
          CustomerList(type: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Utils.navigatePage(context, AddCustomerScreen()),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildLable({String? title, String? number}) {
    return Column(
      children: [
        Text(
          title ?? '',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Text(number ?? '0')
      ],
    );
  }
}
