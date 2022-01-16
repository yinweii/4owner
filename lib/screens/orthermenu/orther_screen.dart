import 'package:flutter/material.dart';
import 'package:owner_app/screens/authentication/authservice.dart';
import 'package:provider/provider.dart';

class OtherMenuScreen extends StatefulWidget {
  const OtherMenuScreen({Key? key}) : super(key: key);

  @override
  _OtherMenuScreenState createState() => _OtherMenuScreenState();
}

class _OtherMenuScreenState extends State<OtherMenuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await Provider.of<AuthService>(context, listen: false).signOut();
          },
          child: const Text('LOGOUT'),
        ),
      ),
    );
  }
}
