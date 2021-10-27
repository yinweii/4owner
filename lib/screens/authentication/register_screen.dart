import 'package:flutter/material.dart';
import 'package:owner_app/constants/app_colors.dart';
import 'package:owner_app/utils/utils.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Đăng kí'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Họ và tên',
                  labelText: 'Họ và tên *',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Số điện thoại',
                  labelText: 'Số điện thoại *',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  labelText: 'Email *',
                ),
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Mật khẩu',
                  labelText: 'Mật khẩu *',
                ),
              ),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    value: isChecked,
                    onChanged: (bool? value) {
                      setState(() {
                        isChecked = value!;
                      });
                    },
                  ),
                  const Text(
                      'Tôi đồng ý với chính sách và điều khoản của 4Owner'),
                ],
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
                    'Đăng kí',
                    style: TextStyle(
                        fontSize: 30,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
