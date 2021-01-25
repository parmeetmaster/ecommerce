import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_happn_replica2/Providers/OtpScreenProvider.dart';
import 'package:flutter_app_happn_replica2/Screens/FacebookScreenDemo.dart';
import 'package:flutter_app_happn_replica2/Screens/FirstScreen.dart';
import 'package:flutter_app_happn_replica2/Screens/GoogleTest.dart';
import 'package:flutter_app_happn_replica2/Screens/OtpScreen.dart';
import 'package:flutter_app_happn_replica2/Screens/OtpScreenDemo.dart';
import 'package:flutter_app_happn_replica2/page/home_page.dart';
import 'package:provider/provider.dart';

import 'Providers/MobileScreenProvider.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => MobileNumberInputProvider()),
        ChangeNotifierProvider(create: (ctx) => OtpScreenProvider()),

      ],
      child: MyApp(),
    ),
    );}

class MyApp extends StatelessWidget {
  static final String title = 'Google SignIn';

  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: title,

    home: FirstScreen(),
  );
}


