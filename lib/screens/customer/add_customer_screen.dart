import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/customer_model.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/floor_provider.dart';
import 'package:owner_app/utils/logger.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen>
    with SingleTickerProviderStateMixin {
  Future<void> getFloor() async {
    await Provider.of<Floor>(context, listen: false).getFloor();
  }

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _cardNunberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  List<File> _listFile = [];
  final picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();
  final devLog = logger;

  @override
  void initState() {
    super.initState();
    getFloor();
  }

  String? _select;
  bool uploading = false;
  double val = 0;

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
      var newCustomer = CustomerModel(
        name: _nameController.text,
        phoneNumber: _phoneNumberController.text,
        dateOfBirth: '',
        cardNumber: _cardNunberController.text,
        email: _emailController.text,
        roomNumber: '',
        floorNumber: _select,
        address: _addressController.text,
        gender: '',
        imageFirstUrl: '',
        imageLastUrl: '',
      );
      context.read<Customer>().addNewCustomer(newCustomer).then(
            (value) => Navigator.of(context).pop(),
          );
      print('CUSTOMER: ${newCustomer.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: RefreshIndicator(
        onRefresh: getFloor,
        child: Form(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      children: [
                        Text('Khu/tầng'),
                        Text(
                          '*',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 6),
                    child: Container(
                      alignment: Alignment.center,
                      child: DropdownButton(
                        hint: Container(
                          width: Utils.sizeWidth(context) * 0.9,
                          child: Text(
                            "${(_select ?? '').isNotEmpty ? _select : 'Vui long chon'}",
                            style: TextStyle(fontWeight: FontWeight.w800),
                          ),
                        ), // Not necessary for Option 1

                        items: context
                            .read<Floor>()
                            .floorList
                            .map((FloorModel floorItem) {
                          return DropdownMenuItem<String>(
                            value: floorItem.name,
                            child: new Text(floorItem.name ?? ''),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          setState(() {
                            _select = value;
                          });
                        },
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: TextFormField(
                      controller: _addressController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 4,
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                    child: Text('Ảnh CMND/CCCD'),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 6, right: 6, bottom: 50),
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
                                  child: _listFile.isEmpty
                                      ? Center(
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                                Icons.add_a_photo_outlined),
                                          ),
                                        )
                                      : SizedBox(
                                          child: Image.file(
                                            _listFile[0],
                                            fit: BoxFit.cover,
                                          ),
                                        )),
                            ),
                            DottedBorder(
                              color: Colors.red,
                              dashPattern: [3, 5],
                              strokeWidth: 2,
                              child: Container(
                                height: 100,
                                width: 140,
                                child: _listFile.isEmpty
                                    ? Center(
                                        child: IconButton(
                                          onPressed: () {},
                                          icon:
                                              Icon(Icons.add_a_photo_outlined),
                                        ),
                                      )
                                    : SizedBox(
                                        child: Image.file(
                                          _listFile[1],
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
      ),
    );
  }
}
