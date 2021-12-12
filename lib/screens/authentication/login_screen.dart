import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/screens/authentication/register_screen.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'authservice.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _emailTextController.text = 'ad@gmail.com';
    _passwordTextController.text = '12345678';
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin(BuildContext context) async {
    await Provider.of<AuthService>(context, listen: false).signIn(
      _emailTextController.text,
      _passwordTextController.text,
    );
  }

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
                controller: _emailTextController,
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
                controller: _passwordTextController,
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
                    _submitLogin(context);
                  },
                  child: const Text(
                    'Đăng nhập',
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
                    'Đăng kí',
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
