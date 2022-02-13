import 'package:flutter/material.dart';
import 'package:owner_app/components/loading_widget.dart';
import 'package:owner_app/constants/export.dart';
import 'package:owner_app/model/user_model.dart';
import 'package:owner_app/provider/profile_provider.dart';
import 'package:owner_app/screens/authentication/authservice.dart';
import 'package:owner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class OtherMenuScreen extends StatefulWidget {
  const OtherMenuScreen({Key? key}) : super(key: key);

  @override
  _OtherMenuScreenState createState() => _OtherMenuScreenState();
}

class _OtherMenuScreenState extends State<OtherMenuScreen> {
  @override
  void initState() {
    super.initState();
    context.read<Profile>().getUserModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: context.watch<Profile>().showLoading
          ? circularProgress()
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),
              child: Column(
                children: [
                  Container(
                    width: Utils.sizeWidth(context),
                    height: 200,
                    decoration: BoxDecoration(
                        color: AppColors.greenFF79AF91,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.grey757575,
                            offset: Offset(0, 3),
                          )
                        ]),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 45,
                            child: Icon(
                              Icons.account_box_outlined,
                            ),
                          ),
                          Text(
                            '${context.watch<Profile>().userModel?.name ?? ''}',
                            style: AppTextStyles.defaultBold,
                          ),
                          Text(
                            '${context.watch<Profile>().userModel?.email ?? ''}',
                            style: AppTextStyles.defaultBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greenFF79AF91,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.help_center),
                      title: Text('Lien he'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greenFF79AF91,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.help_center),
                      title: Text('Lien he'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.greenFF79AF91,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.help_center),
                      title: Text('Lien he'),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () => context.read<AuthService>().signOut(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.greenFF79AF91,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        leading: Icon(Icons.login_outlined),
                        title: Text('LOGOUT'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
