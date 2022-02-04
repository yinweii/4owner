import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:owner_app/constants/constants.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/screens/room/components/tab_controller.dart';

import 'package:provider/src/provider.dart';
import 'package:card_swiper/card_swiper.dart';

import 'components/customer_infor.dart';
import 'components/room_infor.dart';

class RoomDetail extends StatefulWidget {
  final String id;
  const RoomDetail({Key? key, required this.id}) : super(key: key);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  @override
  void initState() {
    super.initState();
    context.read<RoomProvider>().getAllRoom();
  }

  @override
  Widget build(BuildContext context) {
    const images = [
      'https://cdn.24h.com.vn/upload/3-2020/images/2020-08-23/5-mau-nha-cho-thue-dep-nhu-mo-anh--1--1598169830-5-width660height405.jpg',
      'https://cdn.24h.com.vn/upload/3-2020/images/2020-08-23/5-mau-nha-cho-thue-dep-nhu-mo-anh--2--1598169830-672-width640height360.jpg',
      'https://cdn.24h.com.vn/upload/3-2020/images/2020-08-23/5-mau-nha-cho-thue-dep-nhu-mo-anh--3--1598169830-763-width660height471.jpg',
    ];

    var roomData = context.read<RoomProvider>().findRoomById(widget.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(roomData.roomname!),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              height: 250,
              child: Stack(
                children: [
                  Swiper(
                    itemBuilder: (context, index) {
                      return Image.network(
                        images[index],
                        fit: BoxFit.fill,
                      );
                    },
                    autoplay: true,
                    itemCount: images.length,
                    pagination: SwiperPagination(margin: EdgeInsets.all(5.0)),
                    control: const SwiperControl(),
                  ),
                  Positioned(
                    left: 10,
                    top: 5,
                    bottom: 5,
                    child: Text(
                      roomData.status == Constants.room_status_null
                          ? 'Phòng trống'
                          : '',
                      style: AppTextStyles.defaultBold.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 8,
            ),
            TabCupertinoController(roomId: widget.id),
          ],
        ),
      ),
    );
  }
}
