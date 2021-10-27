import 'package:flutter/material.dart';
import 'package:owner_app/components/custom_button.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/screens/authentication/register_screen.dart';
import 'package:owner_app/utils/utils.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 40,
              ),
              const SizedBox(height: 50),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.account_box),
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Mật khẩu',
                  border: OutlineInputBorder(),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red, width: 5),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: Utils.sizeWidth(context),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () {
                    print('LOGIN...');
                  },
                  child: const Text(
                    'LOG IN',
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Container(
                width: Utils.sizeWidth(context),
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextButton(
                  onPressed: () =>
                      Utils.navigatePage(context, const Register()),
                  child: const Text(
                    'REGISTER',
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ], //
          ),
        ),
      ),
    );
  }
}
