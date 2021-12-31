import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/utils/utils.dart';

import 'activity_screen.dart';
import 'components/add_contract_screen.dart';

class ContractScreen extends StatefulWidget {
  const ContractScreen({Key? key}) : super(key: key);

  @override
  _ContractScreenState createState() => _ContractScreenState();
}

class _ContractScreenState extends State<ContractScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 3, vsync: this);
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
        title: const Text('Hợp đồng'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: controller,
          tabs: const <Tab>[
            Tab(
                child: Text(
              'Hoạt động',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            Tab(
              child: Text(
                'Quá hạn',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            Tab(
              child: Text(
                'Đã thanh lý',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          ActivityScreen(),
          Container(),
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Utils.navigatePage(context, AddContractScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
