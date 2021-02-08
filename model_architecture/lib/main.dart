import 'package:auto_route/auto_route_annotations.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/api/SampleCall.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/providers/SampleProvider.dart';

import 'package:model_architecture/screens/otpValidation/OtpValidation.dart';
import 'package:model_architecture/utils/Globals.dart';
import 'file:///D:/git%20main/flutter-modules/model_architecture/lib/api/api_service.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:provider/provider.dart';

import 'screens/HomeScreen/HomeScreen.dart';
import 'utils/preference.dart';

// need to add async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.load();

  if(isPrimaryLanguageset()==false){
   }else{
    }
Globals.primaryLanguage=await getPrimaryLanguage();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => SampleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => HomeScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/second': (context) => OtpValidation(),
      },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
    );
  }
}
