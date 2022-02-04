import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/api_service/api_service.dart';
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

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({Key? key}) : super(key: key);

  @override
  _AddCustomerScreenState createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen>
    with SingleTickerProviderStateMixin {
  Future<void> getFloor() async {
    context.read<Floor>().getFloor();
    context.read<RoomProvider>().getAllRoom();
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

    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) => getFloor());
  }

  String? _select;
  String? _selectRoom;
  bool uploading = false;
  double val = 0;
  List<RoomModel> room = [];
  String? idRooms;

  bool isDeposit = false;

  List<File>? listFile = [];

  File? _selectedImageFile;

  String? urlFirstImg;
  String? urlLastImg;

  File? _selectedImageFileLast;

  bool _isLoading = false;

  // TODO(last code): get image
  Future<void> _onTapImage(int type) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) {
      return;
    }

    await _cropImage(File(pickedFile.path), type);
  }

  Future<void> _cropImage(File? selectedImageFile, int type) async {
    final croppedFile = await ImageCropper.cropImage(
      sourcePath: selectedImageFile?.path ?? '',
      androidUiSettings: const AndroidUiSettings(
          toolbarTitle: '',
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        doneButtonTitle: 'OK',
        cancelButtonTitle: 'Cancel',
        aspectRatioPickerButtonHidden: true,
      ),
    );
    if (croppedFile == null) {
      return;
    }
    setState(() {
      type == 1
          ? _selectedImageFile = croppedFile
          : _selectedImageFileLast = croppedFile;
    });

    //await _updateProfileImage(croppedFile);
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _isLoading = true;
      //todo(): fix bug null file path
      if (_selectedImageFile != null || _selectedImageFileLast != null) {
        await ApiService.saveImageToStore(_selectedImageFile ?? null)!
            .then((value) {
          setState(() {
            urlFirstImg = value;
          });
        });
        await ApiService.saveImageToStore(_selectedImageFileLast ?? null)!
            .then((value) {
          setState(() {
            urlLastImg = value;
          });
        });
      }

      var newCustomer = CustomerModel(
        id: MinId.getId(),
        idfloor: isDeposit ? '' : (_select ?? ''),
        idroom: isDeposit ? '' : (idRooms ?? ''),
        name: _nameController.text,
        phonenumber: _phoneNumberController.text,
        dateOfBirth: '',
        cardnumber: _cardNunberController.text,
        email: _emailController.text,
        roomnumber: _selectRoom ?? '',
        floornumber: isDeposit
            ? ''
            : (context.read<Floor>().findById(_select ?? '').name),
        address: _addressController.text,
        gender: '',
        imagefirsturl: urlFirstImg ?? '',
        imagelasturl: urlLastImg ?? '',
      );
      print(newCustomer.toString());
      context.read<Customer>().addNewCustomer(newCustomer, idRooms ?? '').then(
        (value) {
          _isLoading = false;
          Navigator.of(context).pop();
        },
      );
      print('CUSTOMER: ${newCustomer.toString()}');
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
      body: _isLoading
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
                                      future: getFloor(),
                                      builder: (ctx, snapshort) =>
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
                                          "${(_selectRoom ?? '').isNotEmpty ? _selectRoom : ''}",
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
                                          value: e.roomname,
                                          child: new Text(e.roomname ?? ''),
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
                                      child: _selectedImageFile == null
                                          ? Center(
                                              child: IconButton(
                                                onPressed: () => _onTapImage(1),
                                                icon: Icon(
                                                    Icons.add_a_photo_outlined),
                                              ),
                                            )
                                          : SizedBox(
                                              child: Image.file(
                                                File(_selectedImageFile?.path ??
                                                    ''),
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
                                    child: _selectedImageFileLast == null
                                        ? Center(
                                            child: IconButton(
                                              onPressed: () => _onTapImage(2),
                                              icon: Icon(
                                                  Icons.add_a_photo_outlined),
                                            ),
                                          )
                                        : SizedBox(
                                            child: Image.file(
                                              File(_selectedImageFileLast
                                                      ?.path ??
                                                  ''),
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
