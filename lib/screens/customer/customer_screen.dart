import 'package:flutter/material.dart';
import 'package:owner_app/utils/utils.dart';

import 'add_customer_screen.dart';
import 'components/customer_list.dart';

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
    controller = TabController(length: 2, vsync: this);
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
            indicatorColor: Colors.white,
            controller: controller,
            tabs: const <Tab>[
              Tab(
                  child: Text(
                'Người thuê',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              )),
              Tab(
                child: Text(
                  'Chuyển đi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: controller,
          children: <Widget>[
            CustomerList(),
            Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Utils.navigatePage(context, AddCustomerScreen()),
          child: Icon(Icons.add),
        ));
  }
}
