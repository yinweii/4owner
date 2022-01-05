import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/contract_model.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class AddContractScreen extends StatefulWidget {
  const AddContractScreen({Key? key}) : super(key: key);

  @override
  _AddContractScreenState createState() => _AddContractScreenState();
}

class _AddContractScreenState extends State<AddContractScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Customer>().getListCustomer();
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _depositController = TextEditingController();

  CustomerModel? customer;

  String? selectedValue = null;

  DateTime? selectedFirstDate;
  DateTime? selectedSecondDate;
  DateTime? selectedDateStart;

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

  void _submitContract() async {
    if (_formKey.currentState!.validate()) {
      var newContract = ContractModel(
        id: MinId.getId(),
        createAt: DateTime.now(),
        updateAt: DateTime.now(),
        customer: customer,
        dateFrom: selectedFirstDate,
        dateTo: selectedSecondDate,
        startPay: selectedDateStart,
        numberPerson: int.parse(_priceController.text),
        deposit: double.parse(_depositController.text),
      );
      await context
          .read<Contract>()
          .addContract(newContract)
          .then((value) => Navigator.of(context).pop());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _submitContract,
            icon: Icon(Icons.save),
          ),
        ],
      ),
      body: context.watch<Customer>().showLoading
          ? Center(
              child: CircularProgressIndicator(),
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
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Center(child: Text('Thong tin')),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            _buildLable('Người thuê'),
                            DropdownButtonFormField(
                              validator: (value) =>
                                  value == null ? "Chọn người thuê " : null,
                              //dropdownColor: Colors.blueAccent,
                              value: selectedValue,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedValue = newValue!;
                                  customer = context
                                      .read<Customer>()
                                      .getCustomerByID(selectedValue!);
                                });
                              },
                              items: context
                                  .read<Customer>()
                                  .listCustomer
                                  .map((CustomerModel customer) {
                                return DropdownMenuItem<String>(
                                  value: customer.id,
                                  child: new Text(customer.name ?? ''),
                                );
                              }).toList(),
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
                          color: Colors.green,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5),
                            topRight: Radius.circular(5),
                          ),
                        ),
                        child: Center(
                          child: Text('Tien phong'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            TextFieldCustom(
                              controller: _priceController,
                              lable: 'Số lượng người ',
                              requied: true,
                              type: TextInputType.number,
                            ),
                            SizedBox(height: 6),
                            TextFieldCustom(
                              controller: _depositController,
                              lable: 'Tiền cọc',
                              hintext: 'Tiền cọc',
                              requied: true,
                              type: TextInputType.number,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
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
                    "${selectedFirstDate != null ? DateFormat('dd-MM-yyyy').format(selectedFirstDate!) : 'Từ ngày'} ",
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
