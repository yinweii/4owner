import 'package:flutter/material.dart';

import 'package:owner_app/components/footer_button.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/app_colors.dart';

import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';
import 'authservice.dart';

const LOGIN = 'LOGIN';
const REGISTER = 'REGISTER';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _nameTextController = TextEditingController();

  bool _isLogin = true;
  bool _isLoading = false;
  String dropdownvalue = 'VIE';
  var items = ['VIE', 'ENG'];

  @override
  void initState() {
    super.initState();
    // TODO(): auto fill login
    // _emailTextController.text = 'ad@gmail.com';
    // _passwordTextController.text = '12345678';
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    _passwordTextController.dispose();
    super.dispose();
  }

  Future<void> _submitLogin(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    if (_isLogin) {
      await Provider.of<AuthService>(context, listen: false).signIn(
        _emailTextController.text,
        _passwordTextController.text,
      );
      if ((context.read<AuthService>().errorMessage ?? '').isNotEmpty) {
        Utils.showDialog(
          context: context,
          title: 'Lỗi',
          message: context.read<AuthService>().errorMessage.toString(),
        );
      }
    } else {
      await Provider.of<AuthService>(context, listen: false).register(
        _nameTextController.text,
        _emailTextController.text,
        _passwordTextController.text,
      );
      Utils.showDialog(
        context: context,
        title: 'Lỗi',
        message: context.read<AuthService>().errorMessage.toString(),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _changeForm() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.background,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton(
              elevation: 0,
              value: dropdownvalue,
              icon: Icon(Icons.public_outlined, color: AppColors.blue2),
              items: items.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
        ],
      ),
      body: _isLoading
          ? circularProgress()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _isLogin ? LOGIN : REGISTER,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: AppColors.greenFF79AF91),
                      ),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.only(
                            top: _isLogin ? 60 : 30,
                            bottom: 60,
                            left: 10,
                            right: 10,
                          ),
                          child: Column(
                            children: [
                              !_isLogin
                                  ? TextFormField(
                                      controller: _nameTextController,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.account_box),
                                        labelText: 'User name',
                                        border: OutlineInputBorder(),
                                        errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 5),
                                        ),
                                      ),
                                    )
                                  : SizedBox.shrink(),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: _emailTextController,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.account_box),
                                  labelText: 'Email',
                                  border: OutlineInputBorder(),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              TextFormField(
                                controller: _passwordTextController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock),
                                  labelText: 'Mật khẩu',
                                  border: OutlineInputBorder(),
                                  errorBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.red, width: 5),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        width: Utils.sizeWidth(context),
                        height: 50,
                        child: FooterButton(
                            label: _isLogin ? 'Đăng nhập ' : 'Đăng kí',
                            onPressed: () {
                              _submitLogin(context);
                            }),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        height: 50,
                        width: Utils.sizeWidth(context),
                        child: FooterButton(
                          label: _isLogin ? 'Đăng kí' : 'Đăng nhập',
                          onPressed: () {
                            _changeForm();
                          },
                        ),
                      ),
                    ], //
                  ),
                ),
              ),
            ),
    );
  }
}
