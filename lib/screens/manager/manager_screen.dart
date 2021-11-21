import 'package:flutter/material.dart';
import 'package:owner_app/screens/authentication/authservice.dart';
import 'package:provider/provider.dart';

class ManagerScreen extends StatefulWidget {
  const ManagerScreen({Key? key}) : super(key: key);

  @override
  _ManagerScreenState createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).signOut();
            },
            child: const Text('LOGOUT')),
      ),
    );
  }
}
