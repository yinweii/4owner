import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({Key? key}) : super(key: key);

  @override
  _AddInvoiceState createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  CustomerModel? customerUser;
  final _formKey = GlobalKey<FormState>();

  //controller
  TextEditingController _priceController = TextEditingController();
  // TextEditingController _priceController = TextEditingController();
  // TextEditingController _priceController = TextEditingController();
  String? selectedValue = null;
  DateTime? selectedFirstDate;
  DateTime? selectedSecondDate;
  DateTime? _selectedDate;
  String? price = '';

  double? gia = 0;

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
    getCustommer();
  }

  void _submitContract() async {}
  @override
  Widget build(BuildContext context) {
    print(
        "ROOM: ${context.watch<RoomProvider>().findRoomById('4ZaAS0Qonvia1A').toString()}");
    return Scaffold(
      appBar: AppBar(),
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
                                  customerUser = context
                                      .read<Customer>()
                                      .getCustomerByID(selectedValue!);
                                });
                              },
                              items: context
                                  .read<Customer>()
                                  .listCustomer
                                  .map((CustomerModel customer) {
                                price = customerUser?.idRoom;
                                print('ID ROOM: $price');

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
                              controller: _priceController..text = 'fgdf',
                              lable: 'Tiền phòng',
                              requied: true,
                              type: TextInputType.number,
                            ),
                            SizedBox(height: 6),
                            TextFieldCustom(
                              controller: null,
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
