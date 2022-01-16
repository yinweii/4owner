import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/floor_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/utils/logger.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class EditCustomerScreen extends StatefulWidget {
  final String? id;
  const EditCustomerScreen({Key? key, this.id}) : super(key: key);

  @override
  _EditCustomerScreenState createState() => _EditCustomerScreenState();
}

class _EditCustomerScreenState extends State<EditCustomerScreen>
    with SingleTickerProviderStateMixin {
  // Future<void> getFloor() async {
  //   context.read<Floor>().getFloor();
  //   context.read<RoomProvider>().getAllRoom();
  // }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cardNunberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  List<File> _listFile = [];
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final devLog = logger;

  String? _select;
  String? _selectRoom;
  bool uploading = false;
  double val = 0;
  List<RoomModel> room = [];
  String? idRooms;

  bool isDeposit = false;

  CustomerModel customerModel = CustomerModel();
  Future<void> getFloor() async {
    context.read<Floor>().getFloor();
    context.read<RoomProvider>().getAllRoom();
  }

  @override
  void initState() {
    super.initState();
    customerModel = context.read<Customer>().getCustomerByID(widget.id ?? '');
    initData();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) => getFloor());
  }

  void initData() {
    if ((widget.id ?? '').isNotEmpty) {
      _nameController.text = customerModel.name ?? '';
      _phoneNumberController.text = customerModel.phoneNumber ?? '';
      _emailController.text = customerModel.email ?? '';
      _cardNunberController.text = customerModel.cardNumber ?? '';
      _addressController.text = customerModel.address ?? '';
      if ((customerModel.idFloor ?? '').isEmpty) {
        isDeposit = true;
      } else {
        isDeposit = false;
      }
      // _select = customerModel.floorNumber;
      // _selectRoom = customerModel.roomNumber;
    } else {
      return;
    }
  }

  // TODO(last code): get image
  // Future<void> chooseImage() async {
  //   final pickedFile = await picker.getImage(source: ImageSource.gallery);
  //   setState(
  //     () {
  //       _listFile.add(File(pickedFile?.path ?? ''));
  //     },
  //   );
  //   if (pickedFile?.path == null) retrieveLostData();
  // }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      var customerEdit = customerModel.copyWith(
        idFloor: isDeposit ? '' : (_select ?? ''),
        idRoom: isDeposit ? '' : (idRooms ?? ''),
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        dateOfBirth: '',
        cardNumber: _cardNunberController.text,
        email: _emailController.text,
        roomNumber: _selectRoom ?? '',
        // floorNumber: isDeposit
        //     ? ''
        //     : (context.read<Floor>().findById(_select ?? '').name),
        address: _addressController.text,
      );

      context
          .read<Customer>()
          .updateCustomer(customerEdit, widget.id ?? '', idRooms ?? '')
          .then(
            (value) => Navigator.of(context).pop(),
          );
      print('CUSTOMER: ${customerEdit.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    //room = context.read<RoomProvider?>()?.findListRoom(_select) ?? [];
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Add'),
        actions: [
          IconButton(
            onPressed: () {
              _saveForm();
            },
            icon: Icon(Icons.save_rounded),
          ),
        ],
      ),
      body: context.watch<RoomProvider>().showLoading
          ? circularProgress()
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFieldCustom(
                        controller: _nameController,
                        lable: 'Họ và tên',
                        hintext: 'Họ và tên...',
                        requied: true,
                      ),
                      TextFieldCustom(
                        controller: _phoneNumberController,
                        lable: 'Số điện thoại',
                        hintext: 'Số điện thoại...',
                        type: TextInputType.number,
                      ),
                      TextFieldCustom(
                        controller: _emailController,
                        lable: 'Email',
                        hintext: 'Email...',
                      ),
                      Row(
                        children: [
                          Checkbox(
                            value: this.isDeposit,
                            onChanged: (bool? value) {
                              setState(() {
                                this.isDeposit = value!;
                                print('VALUE: ${this.isDeposit}');
                              });
                            },
                          ),
                          Text('Chưa có phòng(đặt cọc)'),
                        ],
                      ),
                      Visibility(
                        visible: this.isDeposit ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildLable('Khu/tầng'),
                                    FutureBuilder(
                                      future: null,
                                      builder: (ctx, snapshort) =>
                                          DropdownButton(
                                        hint: Container(
                                          width: Utils.sizeWidth(context) * 0.4,
                                          child: Text(
                                            "${(_select ?? '').isNotEmpty ? context.watch<Floor>().findById(_select!).name : '${customerModel.floorNumber ?? ''}'}",
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
                                            child:
                                                new Text(floorItem.name ?? ''),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) async {
                                          setState(
                                            () {
                                              _select = value;
                                            },
                                          );
                                        },
                                      ),
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
                                        child: Text(
                                          "${(_selectRoom ?? '').isNotEmpty ? _selectRoom : '${customerModel.roomNumber ?? ''}'}",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ), // Not necessary for Option 1

                                      items: context
                                          .read<RoomProvider>()
                                          .findListRoom(_select)
                                          .map((e) {
                                        idRooms = e.id;
                                        return DropdownMenuItem<String>(
                                          value: e.romName,
                                          child: new Text(e.romName ?? ''),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          _selectRoom = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextFieldCustom(
                        controller: _cardNunberController,
                        lable: 'Số CMND/CCCD',
                        hintext: 'Số CMND/CCCD...',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text('Địa chỉ'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: TextFormField(
                          controller: _addressController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 4,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 8),
                        child: Text('Ảnh CMND/CCCD'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, bottom: 50),
                        child: Container(
                          width: Utils.sizeWidth(context),
                          height: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                DottedBorder(
                                  color: Colors.red,
                                  dashPattern: [3, 5],
                                  strokeWidth: 2,
                                  child: Container(
                                    height: 100,
                                    width: 140,
                                    child: customerModel.imageFirstUrl == null
                                        ? Center(
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.add_a_photo_outlined),
                                            ),
                                          )
                                        : SizedBox(
                                            child: Image.network(
                                              customerModel.imageFirstUrl ?? '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                                DottedBorder(
                                  color: Colors.red,
                                  dashPattern: [3, 5],
                                  strokeWidth: 2,
                                  child: Container(
                                    height: 100,
                                    width: 140,
                                    child: customerModel.imageLastUrl == null
                                        ? Center(
                                            child: IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                  Icons.add_a_photo_outlined),
                                            ),
                                          )
                                        : SizedBox(
                                            child: Image.network(
                                              customerModel.imageLastUrl ?? '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
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
}
