import 'package:flutter/material.dart';

import 'package:owner_app/model/user_model.dart';

import 'package:owner_app/screens/authentication/authservice.dart';
import 'package:owner_app/screens/authentication/login_screen.dart';
import 'package:owner_app/screens/mypage/mypage.dart';

import 'package:provider/provider.dart';

class WrapScreen extends StatefulWidget {
  const WrapScreen({Key? key}) : super(key: key);

  @override
  _WrapScreenState createState() => _WrapScreenState();
}

class _WrapScreenState extends State<WrapScreen> {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<UserModel?>(
      stream: authService.user,
      builder: (context, snapShort) {
        if (snapShort.connectionState == ConnectionState.active) {
          final UserModel? user = snapShort.data;
          return user == null ? const LogIn() : const MyPage();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
