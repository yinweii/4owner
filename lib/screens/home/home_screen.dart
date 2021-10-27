import 'package:flutter/material.dart';
import 'package:owner_app/constants/export.dart';
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
      body: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: Utils.sizeHeight(context) * 1.5 / 4,
            decoration: const BoxDecoration(
              color: AppColors.blue2,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(60),
              ),
            ),
          ),
          Positioned(
            top: 200,
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
              ),
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
