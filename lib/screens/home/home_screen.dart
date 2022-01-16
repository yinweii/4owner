import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:owner_app/screens/contract/contract_screen.dart';
import 'package:owner_app/screens/customer/customer_screen.dart';
import 'package:owner_app/screens/direct/direct_screen.dart';

import 'package:owner_app/screens/invoice/invoice_screen.dart';
import 'package:owner_app/screens/room_services/service_screen.dart';
import 'package:owner_app/screens/roomholder/holdroom_screen.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/src/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  Future<void> getData() async {
    await context.read<Customer>().getListCustomer();
    await context.read<RoomProvider>().getAllRoom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return circularProgress();
            } else {
              return SingleChildScrollView(
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
                              color: AppColors.greenFF79AF91,
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
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
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
                                      vertical: 10, horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BuildTopItem(
                                            text: 'Tổng số phòng',
                                            number: context
                                                    .read<RoomProvider>()
                                                    .listRoom
                                                    ?.length ??
                                                0,
                                          ),
                                          BuildTopItem(
                                            text: 'Người thuê',
                                            number: context
                                                .read<Customer>()
                                                .listCustomer
                                                .length,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          BuildTopItem(
                                            text: 'Phòng trống',
                                            number: context
                                                .read<RoomProvider>()
                                                .findAllRoomEmpty()
                                                .length,
                                          ),
                                          BuildTopItem(
                                            text: 'Chuyển đi',
                                            number: context
                                                .read<Customer>()
                                                .customerOut()
                                                .length,
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
                      //height: Utils.sizeHeight(context) * 2 / 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: GridView.count(
                          physics: BouncingScrollPhysics(),
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
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
                              onPress: () =>
                                  Utils.navigatePage(context, ContractScreen()),
                              icon: Icon(
                                Icons.thumbs_up_down_outlined,
                                size: 40,
                                color: Colors.deepOrangeAccent,
                              ),
                              text: 'Hợp đồng',
                            ),
                            BuildItem(
                              onPress: () =>
                                  Utils.navigatePage(context, InvoiceScreen()),
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
                              onPress: () => Utils.navigatePage(
                                  context, IndentureScreen()),
                            ),
                            BuildItem(
                                icon: Icon(
                                  Icons.account_balance_wallet_outlined,
                                  size: 40,
                                  color: Colors.deepOrangeAccent,
                                ),
                                text: 'Khoản chi',
                                onPress: () {}),
                            BuildItem(
                              icon: Icon(
                                Icons.clean_hands,
                                size: 40,
                                color: Colors.deepOrangeAccent,
                              ),
                              text: 'Giữ phòng',
                              onPress: () => Utils.navigatePage(
                                context,
                                HoldRoomScreen(),
                              ),
                            ),
                            BuildItem(
                              onPress: () =>
                                  Utils.navigatePage(context, DirectScreen()),
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
                    ),
                  ],
                ),
              );
            }
          }),
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
