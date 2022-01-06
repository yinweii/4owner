import 'package:min_id/min_id.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/provider/floor_provider.dart';
import 'package:owner_app/screens/room/room_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/utils/utils.dart';

class FloorScreen extends StatefulWidget {
  const FloorScreen({Key? key}) : super(key: key);

  @override
  State<FloorScreen> createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _descController = TextEditingController();

  Future<void> getFloor() async {
    await Provider.of<Floor>(context, listen: false).getFloor();
  }

  @override
  void initState() {
    super.initState();
    getFloor();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> saveForm() async {
    var newFloor = FloorModel(
        id: MinId.getId(),
        name: _nameController.text,
        desc: _descController.text);
    await Provider.of<Floor>(context, listen: false)
        .addNewFloor(newFloor)
        .then((value) => cleanForm());
    print('NEW: ${newFloor.toString()}');
  }

  void cleanForm() {
    _nameController.clear();
    _descController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tòa nhà'),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getFloor(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: circularProgress(),
              );
            } else if (snapshot.error != null) {
              return const Center(
                child: Text('An error wrong!'),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<Floor>(
                  builder: (ctx, floorData, _) => GridView.builder(
                    itemCount: floorData.floorList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: (MediaQuery.of(context).orientation ==
                                Orientation.portrait)
                            ? 2
                            : 3),
                    itemBuilder: (context, index) {
                      return BuildFloorItem(
                        idFloor: floorData.floorList[index].id,
                        name: floorData.floorList[index].name,
                      );
                    },
                  ),
                ),
              );
            }
          }),
      floatingActionButton: Container(
        margin: const EdgeInsets.only(
          bottom: 60,
        ),
        child: FloatingActionButton(
          onPressed: () {
            // Add your onPressed code here!
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Dialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0)), //this right here
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tên tòa nhà/tầng...'),
                            ),
                            TextField(
                              controller: _descController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'Mô tả'),
                            ),
                            SizedBox(
                              width: 320.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  primary: AppColors.primary,
                                ),
                                onPressed: () {
                                  saveForm().then(
                                      (value) => Navigator.of(context).pop());
                                },
                                child: const Text('Thêm'),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
          backgroundColor: AppColors.primary,
        ),
      ),
    );
  }
}

class BuildFloorItem extends StatelessWidget {
  final String? idFloor;
  final String? name;
  final String? desc;
  const BuildFloorItem({Key? key, this.idFloor, this.name, this.desc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('IDD: $idFloor');
        Utils.navigatePage(context, RoomScreen(id: idFloor));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.white2,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1, // soften the shadow
                spreadRadius: 1, //extend the shadow
                offset: Offset(
                  1, // Move to right 10  horizontally
                  1, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: Image.asset(
                  'assets/building.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  name!,
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
