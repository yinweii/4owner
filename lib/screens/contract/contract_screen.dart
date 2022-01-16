import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/utils/utils.dart';

import 'components/add_contract_screen.dart';
import 'components/list_contract.dart';

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
          ListContract(type: 1, typeItem: 1),
          ListContract(type: 2, typeItem: 2),
          ListContract(type: 3, typeItem: 3),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => Utils.navigatePage(context, AddContractScreen()),
        child: Icon(Icons.add),
      ),
    );
  }
}
