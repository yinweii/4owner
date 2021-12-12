import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/screens/customer/customer_screen.dart';
import 'package:owner_app/screens/room_services/service_screen.dart';
import 'package:owner_app/utils/utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Utils.sizeHeight(context) * 1 / 3,
              child: Stack(
                children: [
                  Container(
                    height: Utils.sizeHeight(context) * 1 / 4,
                    decoration: const BoxDecoration(
                      color: AppColors.blue2,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(60),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100,
                    right: 3,
                    left: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Container(
                        width: Utils.sizeWidth(context),
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.white3,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.grey,
                              blurRadius: 3, // soften the shadow
                              spreadRadius: 2.0, //extend the shadow
                              offset: Offset(
                                3, // Move to right 10  horizontally
                                3, // Move to bottom 10 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  BuildTopItem(
                                    text: 'Tổng số phòng',
                                    number: 30,
                                  ),
                                  BuildTopItem(
                                    text: 'Người thuê',
                                    number: 50,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  BuildTopItem(
                                    text: 'Phòng trống',
                                    number: 10,
                                  ),
                                  BuildTopItem(
                                    text: 'Chuyển đi',
                                    number: 15,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: Utils.sizeHeight(context) * 2 / 3,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GridView.count(
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  clipBehavior: Clip.antiAlias,
                  children: <Widget>[
                    BuildItem(
                      icon: const Icon(
                        Icons.local_library_outlined,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Dịch vụ',
                      onPress: () => Utils.navigatePage(
                          context, const RoomServiceScreen()),
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.thumbs_up_down_outlined,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Hợp đồng',
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.assignment_outlined,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Hóa đơn',
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.group_add_outlined,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Người thuê',
                      onPress: () =>
                          Utils.navigatePage(context, IndentureScreen()),
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.flag,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Sự cố',
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.clean_hands,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Giữ phòng',
                    ),
                    BuildItem(
                      icon: Icon(
                        Icons.note_add_outlined,
                        size: 40,
                        color: Colors.deepOrangeAccent,
                      ),
                      text: 'Chỉ dẫn',
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildItem extends StatelessWidget {
  const BuildItem({Key? key, this.icon, this.text, this.onPress})
      : super(key: key);
  final Icon? icon;
  final String? text;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.greenLight,
            borderRadius: BorderRadius.circular(15),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 3, // soften the shadow
                spreadRadius: 2.0, //extend the shadow
                offset: Offset(
                  3, // Move to right 10  horizontally
                  3, // Move to bottom 10 Vertically
                ),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              icon!,
              Text(
                text!,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildTopItem extends StatelessWidget {
  const BuildTopItem({Key? key, this.text, this.number}) : super(key: key);
  final String? text;
  final int? number;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text!),
        Text(
          '${number!}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
