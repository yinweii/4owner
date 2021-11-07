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
  final TextEditingController _emailEdtController = TextEditingController();
  final TextEditingController _passwordEdtController = TextEditingController();

  @override
  void dispose() {
    _emailEdtController.dispose();
    _passwordEdtController.dispose();
    super.dispose();
  }

  Future<void> _saveForm(BuildContext context) async {
    await Provider.of<AuthService>(context, listen: false).signIn(
      _emailEdtController.text,
      _passwordEdtController.text,
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
                controller: _emailEdtController,
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
                controller: _passwordEdtController,
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
                    _saveForm(context);
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
