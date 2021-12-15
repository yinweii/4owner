import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/floor_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  final String? id;
  const AddRoomScreen({Key? key, this.id}) : super(key: key);

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _personController = TextEditingController();
  //key
  final _formKey = GlobalKey<FormState>();

  // save form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      var newRoom = RoomModel(
        id: MinId.getId(),
        romName: _nameController.text,
        area: double.parse(_areaController.text),
        price: double.parse(_priceController.text),
        person: int.parse(_personController.text),
        note: _noteController.text,
      );
      context.read<Floor>().addNewRoom(widget.id!, newRoom);

      Navigator.pop(context);
      print(newRoom.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () => _submitForm(), icon: Icon(Icons.save))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFieldCustom(
                  controller: _nameController,
                  lable: 'Tên phòng',
                  requied: true,
                ),
                TextFieldCustom(
                  controller: _priceController,
                  lable: 'Giá',
                  requied: true,
                  type: TextInputType.number,
                ),
                TextFieldCustom(
                  controller: _areaController,
                  lable: 'Diện tích',
                  requied: true,
                  type: TextInputType.number,
                ),
                TextFieldCustom(
                  controller: _personController,
                  lable: 'Giới hạn người thuê',
                  requied: true,
                  type: TextInputType.number,
                ),
                SizedBox(height: 10),
                Text('Ảnh phòng'),
                SizedBox(height: 10),
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                TextFieldCustom(
                  controller: _noteController,
                  lable: 'Ghi chú',
                  requied: true,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
