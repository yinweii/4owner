import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/components/loading_widget.dart';

import 'package:owner_app/provider/floor_provider.dart';

import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'add_room_screen.dart';
import 'edit_room_screen.dart';

class RoomScreen extends StatefulWidget {
  final String? id;

  const RoomScreen({Key? key, this.id}) : super(key: key);

  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  Future<void> getRoom() async {
    Provider.of<RoomProvider>(context, listen: false).getRoom(widget.id);
  }

  @override
  void initState() {
    super.initState();
    getRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Người thuê'),
        centerTitle: true,
      ),
      body: context.watch<RoomProvider>().showLoading
          ? Center(
              child: circularProgress(),
            )
          : Consumer<RoomProvider>(
              builder: (ctx, roomData, _) => (roomData.listRoom ?? [])
                      .isNotEmpty
                  ? GridView.builder(
                      itemCount: roomData.listRoom?.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (MediaQuery.of(context).orientation ==
                                  Orientation.portrait)
                              ? 2
                              : 3),
                      itemBuilder: (ctx, index) {
                        return RoomItem(
                          id: roomData.listRoom?[index].id ?? '',
                          name: roomData.listRoom?[index].romName ?? '',
                          price: roomData.listRoom?[index].price,
                          area: roomData.listRoom?[index].area.toString(),
                          person:
                              roomData.listRoom?[index].listCustomer?.length ??
                                  0,
                        );
                      })
                  : Center(
                      child: Text('Không có phòng nào'),
                    ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Utils.navigatePage(context, AddRoomScreen(id: widget.id)),
        child: Icon(Icons.add),
      ),
    );
  }
}

class RoomItem extends StatelessWidget {
  final String? id;
  final String? name;
  final double? price;
  final int? person;
  final String? area;
  const RoomItem(
      {Key? key, this.id, this.name, this.price, this.person, this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCupertinoModalPopup<void>(
          context: context,
          builder: (BuildContext context) => CupertinoActionSheet(
            actions: <CupertinoActionSheetAction>[
              CupertinoActionSheetAction(
                child: const Text('Chi tiết'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Chỉnh sửa'),
                onPressed: () {
                  Navigator.pop(context);
                  Utils.navigatePage(context, EditRoomScreen(id: id));
                },
              ),
              CupertinoActionSheetAction(
                child: const Text('Xoá'),
                onPressed: () {
                  //TODO (lam sau):
                  //context.read<RoomProvider>().deleteRoom(id!);
                  Navigator.pop(context);
                },
              ),
            ],
            cancelButton: CupertinoActionSheetAction(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Huỷ bỏ')),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: Stack(
          children: [
            Container(
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
                  Container(
                    margin: EdgeInsets.only(top: 15),
                    height: 90,
                    child: Image.asset(
                      'assets/room_img.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Column(
                      children: [
                        Text(
                          name ?? '',
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.green,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          Utils.convertPrice(price),
                          //style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildRow(
                          icon: Icon(Icons.group, size: 18), number: '$person'),
                      _buildRow(
                          icon: Icon(Icons.aspect_ratio, size: 18),
                          number: area),
                      _buildRow(
                          icon: Icon(Icons.warning, size: 18), number: '1'),
                    ],
                  )
                ],
              ),
            ),
            // Positioned(
            //   top: 6,
            //   right: 8,
            //   child: person! < 1
            //       ? Text(
            //           'Chưa \n thuê',
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: Colors.red,
            //               fontSize: 10),
            //         )
            //       : SizedBox.shrink(),
            // ),
          ],
        ),
      ),
    );
  }

  _buildRow({Icon? icon, String? number}) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          icon!,
          SizedBox(width: 5),
          Text(number ?? '0'),
        ],
      ),
    );
  }
}
