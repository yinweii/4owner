import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/components/two_buttons.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/model/room_holder.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/floor_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/provider/roomholder_provider.dart';

import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class AddHoldScreen extends StatefulWidget {
  const AddHoldScreen({Key? key}) : super(key: key);

  @override
  _AddHoldScreenState createState() => _AddHoldScreenState();
}

class _AddHoldScreenState extends State<AddHoldScreen>
    with SingleTickerProviderStateMixin {
  Future<void> getFloorData() async {
    context.read<Floor>().getFloor();
    context.read<RoomProvider>().getAllRoom();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<Customer>().getListCustomer();
    WidgetsBinding.instance
        ?.addPostFrameCallback((timeStamp) => getFloorData());
  }

  String? _select;
  String? _selectRoom;
  bool uploading = false;
  double val = 0;
  List<RoomModel> room = [];
  String? idRooms;
  DateTime? selectedDateStart;
  List<String> _option = const ['Tiền mặt', 'Chuyển khoản']; // Option 2
  String? _selectedOption; // Option 2
  String? selectedValue = null;

  TextEditingController _depositCostController = TextEditingController();

  //
  String? roomName;
  String? customerName;

  // get date
  void _selectDateStart() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 10),
      lastDate: DateTime(DateTime.now().year + 10),
    );
    if (picked != null)
      setState(() {
        selectedDateStart = picked;
      });
  }

  //add new room
  void _saveHolder() {
    if (_formKey.currentState!.validate()) {
      var newHoler = RoomHolderModel(
        id: MinId.getId(),
        customerId: selectedValue ?? '',
        depositCost: double.parse(_depositCostController.text),
        floorNumber: context.read<Floor>().findById(_select ?? '').name ?? '',
        idFloor: _select,
        idRoom: _selectRoom,
        payment: _selectedOption,
        customerName: context
                .read<Customer>()
                .getCustomerByID(selectedValue ?? '')
                .name ??
            '',
        roomNumber: context
            .read<RoomProvider>()
            .findRoomById(_selectRoom ?? '')
            .roomname,
        startTime: selectedDateStart,
      );
      print(newHoler.toString());
      context.read<RoomHolder>().addNewHolder(newHoler);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(),
      body: context.watch<Customer>().showLoading
          ? Center(
              child: circularProgress(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: _depositCostController,
                        style: TextStyle(fontSize: 30),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLable('Khu/tầng'),
                                DropdownButton(
                                  hint: Container(
                                    width: Utils.sizeWidth(context) * 0.4,
                                    child: Text(
                                      "${(_select ?? '').isNotEmpty ? context.watch<Floor>().findById(_select!).name : ''}",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w800),
                                    ),
                                  ), // Not necessary for Option 1

                                  items: context
                                      .read<Floor>()
                                      .floorList
                                      .map((FloorModel floorItem) {
                                    return DropdownMenuItem<String>(
                                      value: floorItem.id,
                                      child: new Text(floorItem.name ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) async {
                                    setState(
                                      () {
                                        _select = value;
                                        print('SELECT: $_select');
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildLable('Phòng'),
                                DropdownButton(
                                  hint: Container(
                                    width: Utils.sizeWidth(context) * 0.4,
                                    // child: Text(
                                    //   "${(_selectRoom ?? '').isNotEmpty ? _selectRoom : ''}",
                                    //   style: TextStyle(
                                    //       fontWeight: FontWeight.w800),
                                    // ),
                                  ),
                                  value: _selectRoom,
                                  items: context
                                      .read<RoomProvider>()
                                      .findRoomEmpty(_select)
                                      .map((e) {
                                    return DropdownMenuItem<String>(
                                      value: e.id,
                                      child: new Text(e.roomname ?? ''),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectRoom = value;
                                      context
                                          .read<RoomProvider>()
                                          .findRoomById(_selectRoom ?? '');
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildLable('Ngày bắt đầu tính tiền'),
                      SizedBox(height: 10),
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
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${selectedDateStart != null ? DateFormat('dd-MM-yyyy').format(selectedDateStart!) : 'Ngày vào ở'} ",
                              ),
                              GestureDetector(
                                onTap: _selectDateStart,
                                child: Icon(Icons.date_range_outlined),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildLable('Phương thức thanh toán'),
                          DropdownButton(
                            hint: Text(
                                'Choose payment'), // Not necessary for Option 1
                            value: _selectedOption,
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedOption = newValue;
                                print('SELECT OPTION: $_selectedOption');
                              });
                            },
                            items: _option.map((option) {
                              return DropdownMenuItem(
                                child: new Text(option),
                                value: option,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _buildLable('Người đặt cọc'),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(style: BorderStyle.none),
                        ),
                        child: DropdownButtonFormField(
                          validator: (value) =>
                              value == null ? "Chọn người thuê " : null,
                          //dropdownColor: Colors.blueAccent,
                          value: selectedValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedValue = newValue!;
                              print('CUSTOMER: $selectedValue');
                            });
                          },
                          items: context
                              .read<Customer>()
                              .customerDeposit()
                              .map((CustomerModel customer) {
                            return DropdownMenuItem<String>(
                              value: customer.id,
                              child: new Text(customer.name ?? ''),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(height: 30),
                      TwoButtonsFooter(
                        leftButtonLabel: 'Hủy bỏ',
                        rightButtonLabel: 'Xác nhận',
                        leftButtonColor: Colors.grey,
                        onLeftButtonPressed: () {},
                        rightButtonColor: Colors.green,
                        onRightButtonPressed: _saveHolder,
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
}
