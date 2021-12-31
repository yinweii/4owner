import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/screens/invoice/components/service_item.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  CustomerModel? customerUser;
  final _formKey = GlobalKey<FormState>();

  //Electricity controller
  TextEditingController _controllerElectLast = TextEditingController();
  TextEditingController _controllerElectCurent = TextEditingController();
  TextEditingController _controllerElectPrice = TextEditingController();

  //water
  TextEditingController _controllerWaterLast = TextEditingController();
  TextEditingController _controllerWaterCurent = TextEditingController();
  TextEditingController _controllerWaterPrice = TextEditingController();

  double? amount;
  double? amountWater;

  //controller
  TextEditingController _priceController = TextEditingController();

  String? selectedValue = null;
  DateTime? selectedFirstDate;
  DateTime? selectedSecondDate;
  DateTime? _selectedDate;

  RoomModel? roomModel;

  Future<void> getCustommer() async {
    await context.read<Customer>().getListCustomer();
    await context.read<RoomProvider>().getAllRoom();
  }

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

  void _selectMonth() async {
    showMonthPicker(
      context: context,
      firstDate: DateTime(DateTime.now().year - 1, 5),
      lastDate: DateTime(DateTime.now().year + 1, 9),
      initialDate: _selectedDate ?? DateTime.now(),
      locale: Locale("vi"),
    ).then((date) {
      if (date != null) {
        setState(() {
          _selectedDate = date;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //_priceController.addListener();
    getCustommer();

    //add listener eclectric controller
    _controllerElectLast.addListener(_totalElectric);
    _controllerElectCurent.addListener(_totalElectric);
    _controllerElectPrice.addListener(_totalElectric);

    //add listener water controller
    _controllerWaterLast.addListener(_amountWater);
    _controllerWaterCurent.addListener(_amountWater);
    _controllerWaterPrice.addListener(_amountWater);
  }

  void _amountWater() {
    var last = _controllerWaterLast.text;
    var current = _controllerWaterCurent.text;
    var price = _controllerWaterPrice.text;
    amountWater =
        (double.parse(current) - double.parse(last)) * double.parse(price);
  }

  void _totalElectric() {
    var last = _controllerElectLast.text;
    var current = _controllerElectCurent.text;
    var price = _controllerElectPrice.text;
    amount = (double.parse(current) - double.parse(last)) * double.parse(price);
  }

  void _submitContract() async {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: context.watch<Customer>().showLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
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
                        child: Center(child: Text('Thông tin')),
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
                                  customerUser = context
                                      .read<Customer>()
                                      .getCustomerByID(selectedValue!);
                                  roomModel = context
                                      .read<RoomProvider>()
                                      .findRoomById(customerUser?.idRoom ?? '');
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
                            _buildLable('Hoá đơn tháng'),
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
                                      "${_selectedDate != null ? DateFormat('MM-yyyy').format(_selectedDate!) : 'Hoá đơn tháng'} ",
                                    ),
                                    GestureDetector(
                                      onTap: _selectMonth,
                                      child: Icon(Icons.date_range_outlined),
                                    ),
                                  ],
                                ),
                              ),
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
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      _buildHeader('Tiền phòng'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            TextFieldCustom(
                              controller: _priceController
                                ..text = roomModel?.price.toString() ?? '',
                              lable: 'Tiền phòng',
                              requied: true,
                              type: TextInputType.number,
                            ),
                            SizedBox(height: 6),
                          ],
                        ),
                      ),
                      _buildHeader('Dịch vụ'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 8),
                        child: Column(
                          children: [
                            SizedBox(height: 6),
                            BuildCard(
                              controllerLast: _controllerElectLast,
                              controllerCurent: _controllerElectCurent,
                              controllerPrice: _controllerElectPrice,
                              amount: amount,
                              name: 'Điện',
                            ),
                            BuildCard(
                              controllerLast: _controllerWaterLast,
                              controllerCurent: _controllerWaterCurent,
                              controllerPrice: _controllerWaterPrice,
                              amount: amountWater,
                              name: 'Nước',
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildHeader(String title) {
    return Container(
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
        child: Text(title),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controllerElectLast.dispose();
    _controllerElectCurent.dispose();
    _controllerElectPrice.dispose();

    //disponse
    _controllerWaterLast.dispose();
    _controllerWaterCurent.dispose();
    _controllerWaterPrice.dispose();
  }
}
