// ignore_for_file: must_be_immutable
//todo:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/service_model.dart';
import 'package:owner_app/provider/service_provider.dart';
import 'package:provider/provider.dart';

class RoomServiceScreen extends StatefulWidget {
  const RoomServiceScreen({Key? key}) : super(key: key);

  @override
  _RoomServiceScreenState createState() => _RoomServiceScreenState();
}

class _RoomServiceScreenState extends State<RoomServiceScreen> {
  bool? isChecked = false;
  final TextEditingController _nameService = TextEditingController();
  final TextEditingController _priceService = TextEditingController();
  final TextEditingController _noteService = TextEditingController();
  String? status;

  String _setStatus() {
    if (isChecked!) {
      return 'Miễn phí';
    }
    return 'Trả phí';
  }

  Future<void> getData() async {
    await Provider.of<ServiceProvider>(context, listen: false)
        .getRoomServiceFree();
    await Provider.of<ServiceProvider>(context, listen: false)
        .getRoomServiceFee();
    await Provider.of<ServiceProvider>(context, listen: false)
        .getAllServiceFree();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> _submitService() async {
    var newService = RoomService(
      name: _nameService.text,
      price:
          _priceService.text.isNotEmpty ? double.parse(_priceService.text) : 0,
      note: _noteService.text,
      status: _setStatus(),
    );

    print('NEW SERVICE: ${newService.toString()}');
    await context.read<ServiceProvider>().addNewServiceFloor(newService);
  }

  Future<void> _editService(String id) async {
    // var roomService = context.read<ServiceProvider>().findById(id);
    var editService = RoomService(
      name: _nameService.text,
      price:
          _priceService.text.isNotEmpty ? double.parse(_priceService.text) : 0,
      note: _noteService.text,
      status: _setStatus(),
    );
    print('UPDATE SERVICE: ${editService.toString()}');
    await context.read<ServiceProvider>().updateService(id, editService);
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    final listFreeService = Provider.of<ServiceProvider>(context).serviceList;

    final listFreeServiceFee =
        Provider.of<ServiceProvider>(context).serviceListFee;
    final item = listFreeService
        .map(
          (e) => ServiceItem(
            onPress: () {
              _showDialog(context, e.id ?? '');
            },
            onLogPress: () {
              confirmDiaglog(context, e.id!);
            },
            name: e.name,
            note: e.note,
          ),
        )
        .toList();
    final itemFee = listFreeServiceFee
        .map(
          (e) => ServiceItem(
            onPress: () {
              _showDialog(context, e.id ?? '');
            },
            onLogPress: () {
              confirmDiaglog(context, e.id!);
            },
            name: e.name,
            note: e.note,
          ),
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dịch vụ'),
      ),
      body: context.watch<ServiceProvider>().isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Miễn phí',
                      style: TextStyle(fontSize: 20),
                    ),
                    ...item,
                    const Text(
                      'Trả phí',
                      style: TextStyle(fontSize: 20),
                    ),
                    ...itemFee,
                  ],
                ),
              ),
            ),
      floatingActionButton: SizedBox(
        child: FloatingActionButton(
          onPressed: () {
            clearForm();
            // Add your onPressed code here!
            _showDialog(context, '');
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }

  void confirmDiaglog(BuildContext context, String id) {
    showDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: const Text("Thông báo"),
            content: const Text("Bạn muốn xóa dịch vụ này"),
            actions: <Widget>[
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("Yes"),
                  onPressed: () async {
                    await context
                        .read<ServiceProvider>()
                        .deleteService(id)
                        .then((value) => Navigator.of(context).pop());
                  }),
              CupertinoDialogAction(
                child: const Text("No"),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  void _showDialog(BuildContext context, String? id) {
    final service = context.read<ServiceProvider>().findById(id ?? '');
    print(service.toString());
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          // StatefulBuilder
          builder: (context, setState) {
            return AlertDialog(
              actions: <Widget>[
                Container(
                  width: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        id == '' ? "Thêm dịch vụ" : 'Sửa thông tin',
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        height: 2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: id == ''
                            ? _nameService
                            : (_nameService..text = service?.name ?? ''),
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Tên dịch vụ'),
                      ),
                      TextField(
                        controller: id == ''
                            ? _priceService
                            : (_priceService..text = service!.price.toString()),
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Giá'),
                        keyboardType: TextInputType.number,
                      ),
                      TextField(
                        controller: id == ''
                            ? _noteService
                            : (_noteService..text = service?.note ?? ''),
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: 'Note'),
                      ),
                      CheckboxListTile(
                        value: isChecked!,
                        title: const Text("Miễn phí"),
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                            print(isChecked);
                          });
                        },
                      ),
                      const Divider(
                        height: 10,
                      ),
                      const Divider(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                clearForm();
                                Navigator.of(context).pop();
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.red,
                            ),
                            child: const Text('Cancel'),
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              id == ''
                                  ? await _submitService()
                                  : await _editService(id ?? '');
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppColors.primary,
                            ),
                            child: const Text('Save'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void clearForm() {
    _nameService.clear();
    _priceService.clear();
    _noteService.clear();
  }
}

class ServiceItem extends StatelessWidget {
  ServiceItem(
      {Key? key,
      this.id,
      this.name,
      this.price,
      this.note,
      this.onPress,
      this.onLogPress,
      this.isFree = false})
      : super(key: key);
  final String? id;
  final String? name;
  final String? price;
  final String? note;
  bool isFree;
  final VoidCallback? onPress;
  final VoidCallback? onLogPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      onLongPress: onLogPress,
      child: Card(
        child: ListTile(
          leading: const Icon(Icons.home_filled),
          title: Text(name ?? ''),
          subtitle: Text(price ?? ''),
        ),
      ),
    );
  }
}
