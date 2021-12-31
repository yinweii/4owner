import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/screens/contract/components/contract_item.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key? key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Contract>().getAllContract();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<Contract>().showLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: CupertinoSearchTextField(),
                  ),
                  Container(
                    width: Utils.sizeWidth(context),
                    height: Utils.sizeHeight(context) * 0.8,
                    child: Consumer<Contract>(
                      builder: (ctx, contract, _) => ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: contract.contractList.length,
                        itemBuilder: (ctx, index) {
                          return ContractItem(
                            id: contract.contractList[index].id,
                            floorNumber: contract
                                .contractList[index].customer?.floorNumber,
                            roomNumber: contract
                                .contractList[index].customer?.roomNumber,
                            dateFrom: contract.contractList[index].dateFrom ??
                                DateTime.now(),
                            dateTo: contract.contractList[index].dateTo ??
                                DateTime.now(),
                            customerName:
                                contract.contractList[index].customer?.name,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
