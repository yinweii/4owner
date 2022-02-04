import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

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
    context.read<Contract>().getAllContract();
    controller = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var count = context.watch<Contract>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hợp đồng',
          style: AppTextStyles.defaultBoldAppBar,
        ),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: controller,
          tabs: <Tab>[
            _buildTab('Hoạt động',
                count.listContractAc(status: false, isActive: true).length),
            _buildTab('Quá hạn', count.listContractAc().length),
            _buildTab('Đã thanh lý', count.listContractOut().length),
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

  Tab _buildTab(String lable, int? count) {
    return Tab(
      child: Column(
        children: [
          Text(
            lable,
            style: AppTextStyles.defaultBold.copyWith(
              fontSize: AppTextStyles.fontSize_15,
              color: AppColors.white2,
            ),
          ),
          Text(
            '${count ?? 0}',
            style: AppTextStyles.defaultBold.copyWith(
              fontSize: AppTextStyles.fontSize_15,
              color: AppColors.white2,
            ),
          ),
        ],
      ),
    );
  }
}
