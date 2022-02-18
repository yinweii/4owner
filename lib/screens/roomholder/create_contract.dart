import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/components/two_buttons.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/constants/app_text.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/model/contract_model.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/room_holder.dart';
import 'package:owner_app/provider/contract_provider.dart';

import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/roomholder_provider.dart';
import 'package:owner_app/utils/diaglog_util.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

import 'holdroom_screen.dart';

class CreateContractScreen extends StatefulWidget {
  final String? id;
  const CreateContractScreen({Key? key, this.id}) : super(key: key);

  @override
  _CreateContractScreenState createState() => _CreateContractScreenState();
}

class _CreateContractScreenState extends State<CreateContractScreen> {
  //
  CustomerModel? customerModel;
  RoomHolderModel? holderModel;
  DateTime? selectedFirstDate;
  DateTime? selectedSecondDate;
  DateTime? selectedDateStart;
  TextEditingController _numberPersonController = TextEditingController();
  // TextEditingController _depositController = TextEditingController();

  // get date
  void _selectDate(bool isFirstDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null &&
        (picked != selectedFirstDate || picked != selectedSecondDate))
      setState(() {
        isFirstDate ? selectedFirstDate = picked : selectedSecondDate = picked;
      });
  }

  // get date
  void _selectDateStart() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null &&
        (picked != selectedFirstDate || picked != selectedSecondDate))
      setState(() {
        selectedDateStart = picked;
      });
  }

  @override
  void initState() {
    super.initState();
    context.read<Customer>().getListCustomer();
    holderModel = context.read<RoomHolder>().findHolderById(widget.id ?? '');
  }

  void _submitContract() async {
    if (_formKey.currentState!.validate()) {
      var newContract = ContractModel(
        id: MinId.getId(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        idCustomer: holderModel?.customerId,
        dateFrom: selectedFirstDate ?? holderModel?.startTime,
        dateTo: selectedSecondDate,
        startPay: selectedDateStart,
        numberPerson: int.parse(_numberPersonController.text),
        deposit: holderModel?.depositCost,
      );

      await context.read<Contract>().addContract(newContract, '').then((value) {
        Utils.navigateReplace(context, HoldRoomScreen());
      }, onError: (error) => DialogUtil.showError(context, error.toString()));
      await context
          .read<RoomHolder>()
          .updateStatus(widget.id ?? '', Constants.holder_readly);
    }
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: context.watch<Customer>().showLoading
          ? Center(
              child: circularProgress(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 3),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: Utils.sizeWidth(context),
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Center(
                            child: Text(
                          'Thông tin',
                          style: AppTextStyles.defaultBold.copyWith(
                            color: AppColors.white2,
                          ),
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            Text(
                              '${holderModel?.customerName}',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                            SizedBox(height: 6),
                            _buildLable('Thời hạn'),
                            SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                _buildSelectDate(true),
                                _buildSelectDate(false),
                              ],
                            ),
                            SizedBox(height: 6),
                            _buildLable('Ngày bắt đầu tính tiền'),
                            SizedBox(height: 6),
                            Container(
                              height: 40,
                              //width: Utils.sizeWidth(context) * 0.4,
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${selectedDateStart != null ? DateFormat('dd-MM-yyyy').format(selectedDateStart!) : 'Ngày bắt đầu tính tiền'} ",
                                    ),
                                    GestureDetector(
                                      onTap: _selectDateStart,
                                      child: Icon(Icons.date_range_outlined),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: Utils.sizeWidth(context),
                        height: 35,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Tiền phòng',
                            style: AppTextStyles.defaultBold.copyWith(
                              color: AppColors.white2,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            Text(
                              'Tiền cọc: ${holderModel?.depositCost}',
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 10),
                            TextFieldCustom(
                              controller: _numberPersonController,
                              lable: 'Số lượng người ',
                              requied: true,
                              type: TextInputType.number,
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: 10),
        child: TwoButtonsFooter(
          leftButtonLabel: 'Hủy bỏ',
          rightButtonLabel: 'Tạo hợp đồng',
          leftButtonColor: Colors.grey,
          onLeftButtonPressed: () => Navigator.pop(context),
          rightButtonColor: Colors.green,
          onRightButtonPressed: _submitContract,
        ),
      ),
    );
  }

  Widget _buildLable(String title) {
    return Row(
      children: [
        Text(title),
        SizedBox(width: 5),
        Text(
          '*',
          style: TextStyle(color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildSelectDate(bool isFirst) {
    return Container(
      height: 40,
      width: Utils.sizeWidth(context) * 0.4,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isFirst
                ? Text(
                    "${selectedFirstDate != null ? DateFormat('dd-MM-yyyy').format(selectedFirstDate!) : '${DateFormat('dd-MM-yyyy').format(holderModel!.startTime!)}'} ",
                  )
                : Text(
                    "${selectedSecondDate != null ? DateFormat('dd-MM-yyyy').format(selectedSecondDate!) : 'Đến ngày'} ",
                  ),
            GestureDetector(
              onTap: () => isFirst ? _selectDate(true) : _selectDate(false),
              child: Icon(Icons.date_range_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
