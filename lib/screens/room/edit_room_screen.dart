import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/components/custom_textfield.dart';
import 'package:owner_app/model/room_model.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:provider/src/provider.dart';

class EditRoomScreen extends StatefulWidget {
  final String? id;
  const EditRoomScreen({Key? key, this.id}) : super(key: key);

  @override
  _EditRoomScreenState createState() => _EditRoomScreenState();
}

class _EditRoomScreenState extends State<EditRoomScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noteController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _personController = TextEditingController();
  //key
  final _formKey = GlobalKey<FormState>();

  var _editRoom = RoomModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _editRoom = context.read<RoomProvider>().findRoomById(widget.id ?? '');
  }

  // save form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      var newRoom = _editRoom.copyWith(
        romName: _nameController.text,
        area: double.parse(_areaController.text),
        price: double.parse(_priceController.text),
        note: _noteController.text,
      );
      //TODO (lam sau):
      //context.read<RoomProvider>().editRoom(widget.id ?? '', newRoom);
      print('New Room: ${newRoom.toString()}');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_editRoom.toString());
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
                  controller: _nameController..text = _editRoom.romName ?? '',
                  lable: 'Tên phòng',
                  requied: true,
                ),
                TextFieldCustom(
                  controller: _priceController
                    ..text = _editRoom.price.toString(),
                  lable: 'Giá',
                  requied: true,
                  type: TextInputType.number,
                ),
                TextFieldCustom(
                  controller: _areaController..text = _editRoom.area.toString(),
                  lable: 'Diện tích',
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
                  controller: _noteController..text = _editRoom.note ?? '',
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
