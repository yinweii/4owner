import 'package:flutter/material.dart';

import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'add_room_screen.dart';

class RoomScreen extends StatefulWidget {
  final String? id;
  final String? name;
  const RoomScreen({Key? key, this.id, this.name}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen>
    with SingleTickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Người thuê'),
        centerTitle: true,
        bottom: TabBar(
          indicatorColor: Colors.white,
          controller: controller,
          tabs: const <Tab>[
            Tab(
                child: Text(
              'Danh sách phòng',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            )),
            Tab(
              child: Text(
                'Chi tiết',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          _buildListRoom(),
          Container(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Utils.navigatePage(context, AddRoomScreen()),
        child: Icon(Icons.add),
      ),
    );
  }

  _buildListRoom() {
    return Consumer<RoomProvider>(
      builder: (ctx, roomData, _) => GridView.builder(
        itemCount: roomData.listRoom.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                (MediaQuery.of(context).orientation == Orientation.portrait)
                    ? 2
                    : 3),
        itemBuilder: (context, index) {
          return RoomItem(
            name: roomData.listRoom[index].romName,
            price: roomData.listRoom[index].price.toString(),
            person: roomData.listRoom[index].person.toString(),
          );
        },
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  final String? name;
  final String? price;
  final String? person;
  final String? area;
  const RoomItem({Key? key, this.name, this.price, this.person, this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
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
                height: 100,
                child: Image.asset(
                  'assets/room.png',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Column(
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      price ?? '',
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildRow(icon: Icon(Icons.group), number: '3'),
                  _buildRow(icon: Icon(Icons.aspect_ratio), number: '3'),
                  _buildRow(icon: Icon(Icons.warning), number: '3'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildRow({Icon? icon, String? number}) {
    return Row(
      children: [
        icon!,
        Text(number ?? '0'),
      ],
    );
  }
}
