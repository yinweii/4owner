import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/floor_model.dart';
import 'package:owner_app/room/room_screen.dart';
import 'package:owner_app/utils/utils.dart';

class FloorScreen extends StatefulWidget {
  const FloorScreen({Key? key}) : super(key: key);

  @override
  _FloorScreenState createState() => _FloorScreenState();
}

class _FloorScreenState extends State<FloorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GROUP'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: listFloor.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  (MediaQuery.of(context).orientation == Orientation.portrait)
                      ? 2
                      : 3),
          itemBuilder: (context, index) {
            return BuildFloorItem(
              name: listFloor[index].name,
            );
          },
        ),
      ),
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
                            const TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Tên tòa nhà/tầng...'),
                            ),
                            const TextField(
                              decoration: InputDecoration(
                                  border: InputBorder.none, hintText: 'Mô tả'),
                            ),
                            SizedBox(
                              width: 320.0,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 20),
                                  primary: AppColors.primary,
                                ),
                                onPressed: () {},
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
  final String? name;
  final String? desc;
  const BuildFloorItem({Key? key, this.name, this.desc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Utils.navigatePage(context, RoomScreen()),
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
