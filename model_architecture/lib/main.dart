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

import 'utils/preference.dart';

// need to add async
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preference.load();


  if(isPrimaryLanguageset()==false){

   }else{

    }

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
        '/': (context) => MyHomePage(title: 'Flutter Demo Home Page'),
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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Consumer<SampleProvider>(
        builder: (context, value,child) {
     final   sampleprovider=  Provider.of<SampleProvider>(context);
          return Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
            onTap: (){
              sampleprovider.sentOtp();
            },
                  child: Text(
                    '${LanguageEn().appName}',
                  ),
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
