import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:min_id/min_id.dart';
import 'package:owner_app/model/more_service_model.dart';
import 'package:owner_app/provider/contract_provider.dart';
import 'package:owner_app/provider/customer_provider.dart';
import 'package:owner_app/provider/invoice_provider.dart';
import 'package:owner_app/provider/room_provide.dart';
import 'package:provider/provider.dart';
import 'constants/app_colors.dart';
import 'constants/app_text.dart';
import 'provider/floor_provider.dart';
import 'provider/roomholder_provider.dart';
import 'provider/service_provider.dart';
import 'screens/authentication/authservice.dart';
import 'screens/authentication/wrap_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MinId.withPattern('{1{d}}{1{w}}{3{w}}{1{d}}{3{w}}{3{w}}{d}{w}');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => Floor()),
        Provider(create: (ctx) => AuthService()),
        ChangeNotifierProvider(create: (ctx) => ServiceProvider()),
        ChangeNotifierProvider(create: (ctx) => Customer()),
        ChangeNotifierProvider(create: (ctx) => RoomProvider()),
        ChangeNotifierProvider(create: (ctx) => Contract()),
        ChangeNotifierProvider(create: (ctx) => MoreService()),
        ChangeNotifierProvider(create: (ctx) => Invoice()),
        ChangeNotifierProvider(create: (ctx) => RoomHolder()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColorBrightness: Brightness.dark,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: AppColors.primary,
          appBarTheme: const AppBarTheme(
            color: AppColors.primary,
            iconTheme: IconThemeData(
              color: AppColors.white,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: AppColors.background,
          textTheme: TextTheme(
            subtitle1: AppTextStyles.defaultBold,
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: AppColors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
          ),
        ),
        home: const WrapScreen(),
      ),
    );
  }
}
