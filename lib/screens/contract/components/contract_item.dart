import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/row_btn.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/screens/contract/components/edit_contract_screen.dart';
import 'package:owner_app/utils/diaglog_util.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

class ContractItem extends StatefulWidget {
  const ContractItem({
    Key? key,
    this.id,
    this.roomNumber,
    this.floorNumber,
    this.dateFrom,
    this.dateTo,
    this.customerName,
    required this.typeItem,
    this.customerId,
  }) : super(key: key);
  final String? id;
  final int typeItem;
  final String? roomNumber;
  final String? floorNumber;
  final DateTime? dateFrom;
  final DateTime? dateTo;
  final String? customerName;
  final String? customerId;

  @override
  State<ContractItem> createState() => _ContractItemState();
}

class _ContractItemState extends State<ContractItem> {
  var _isShow = false;

  void _showBtn() {
    setState(() {
      _isShow = !_isShow;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showBtn,
      child: Container(
        height: 150,
        width: Utils.sizeWidth(context),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "# ${widget.id}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.home_work_outlined,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${widget.floorNumber}-${widget.roomNumber}",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.green),
                    )
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.date_range_outlined,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "${DateFormat('dd-MM-yyyy').format(widget.dateFrom!)} ?????n ${widget.dateTo != null ? DateFormat('dd-MM-yyyy').format(widget.dateTo!) : '[Kh??ng x??c ?????nh]'}",
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person_outline_outlined,
                    ),
                    SizedBox(width: 5),
                    Text('${widget.customerName}')
                  ],
                ),
                SizedBox(height: 5),
                Visibility(
                  visible: _isShow ? true : false,
                  child: Row(
                    children: [
                      Expanded(
                        child: Visibility(
                          visible: widget.typeItem == 2 ? false : true,
                          child: BuildButton(
                            name: 'X??a',
                            color: Colors.red[300],
                            onPress: () => DialogUtil.cupertioDialog(
                              context: context,
                              content: 'B???n mu???n xo?? h???p ?????ng n??y?',
                              yesAction: () => context
                                  .read<Contract>()
                                  .deleteContract(widget.id!)
                                  .then((value) {
                                context
                                    .read<Customer>()
                                    .deleteCustomer(widget.customerId!);
                              }),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: BuildButton(
                          name: 'Chi ti???t',
                          onPress: () {},
                          color: AppColors.greenFF79AF91,
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Visibility(
                          visible: widget.typeItem == 3 ? false : true,
                          child: BuildButton(
                            name: widget.typeItem == 2 ? 'Ra h???n' : 'Ch???nh s???a',
                            onPress: () {
                              Utils.navigatePage(
                                  context, EditContractScreen(id: widget.id));
                            },
                            color: AppColors.yellowFFE5D26A,
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Visibility(
                          visible: widget.typeItem == 3 ? false : true,
                          child: BuildButton(
                            name: 'Thanh l??',
                            onPress: () {
                              DialogUtil.cupertioDialog(
                                  context: context,
                                  title: 'Thanh l?? h???p ?????ng',
                                  content: 'B???n c?? ch???c thanh l?? h???p ?????ng n??y!',
                                  yesAction: () => context
                                      .read<Contract>()
                                      .updateStatus(widget.id ?? '',
                                          widget.customerId ?? '')
                                      .then((value) => context
                                          .read<Contract>()
                                          .onRefresh()));
                              //todo:() remove show dialog
                              // DialogUtil.cupertioDialog(
                              //     context,
                              //     'Thanh l?? h???p ?????ng',
                              //     'B???n c?? ch???c thanh l?? h???p ?????ng n??y!',
                              //     () =>

                              //         .then((value) =>
                              //             context.read<Contract>().onRefresh()));
                            },
                            color: AppColors.grey757575,
                          ),
                        ),
                      ),
                    ],
                  ),
                  replacement: SizedBox.shrink(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
