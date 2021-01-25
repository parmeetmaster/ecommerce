import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_zomato_signin/Providers/OtpScreenProvider.dart';
import 'package:flutter_app_zomato_signin/Widget/MobileNumerWidget.dart';
import 'package:flutter_app_zomato_signin/support/ConstantsVariables.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import 'OtpScreen.dart';
import 'Providers/LoginScreenProvider.dart';
import 'Providers/OtpCountDownProvider.dart';
import 'Services/preference.dart';
import 'support/code_country.dart';
import 'support/country_list_pick.dart';

void main() {
  Preference.load();
  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (ctx)=>LoginProvider()),
      ChangeNotifierProvider(create: (ctx)=>OtpScreenProvider()),
        ChangeNotifierProvider(create: (ctx)=>OtpCountDownProvider())
      ],
 child: MyApp(),
    )


  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context)=>ZomatoLoginStateful(title:"hello"),
        '/otpscreen':(context)=>OtpScreen()
      },

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),

    );
  }
}

class ZomatoLoginStateful extends StatefulWidget {
  ZomatoLoginStateful({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ZomatoLoginStatefulState createState() => _ZomatoLoginStatefulState();
}

class _ZomatoLoginStatefulState extends State<ZomatoLoginStateful> {
  ScrollController controller;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();




  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    Size size = MediaQuery
        .of(context)
        .size;

    showErrorUsingSnackBar(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message),));
    provider.isloading=false;
    provider.refreshScreen();
    }


    return Scaffold(
      resizeToAvoidBottomInset: true,
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: Consumer<LoginProvider>(
        builder: (loginConsumerContext, value,child) {
          value.context=loginConsumerContext;

         return Stack(
           children: [

             Container(
               height: size.height,
               width: size.width,
               child: Image.asset(
                 'assets/images/bg.png',
                 fit: BoxFit.fill,
               ),
             ),
             Container(color: Colors.black38,), Column(
               children: [
                 Expanded(
                   child: GestureDetector(
                     onTap:  () {

                     },
                     child: Container(
                       margin: EdgeInsets.only(top: 30, right: 20),
                       child: Align(
                           alignment: Alignment.topRight,
                           child: MaterialButton(
                             onPressed: () {
/*
                               String phno=  provider.validatePhoneNumber(textController.text);
                               provider.login('+91', textController.text);*/

                             },
                             color: Colors.black45,
                             minWidth: 70,
                             shape: RoundedRectangleBorder(
                                 borderRadius: new BorderRadius.circular(30.0)),
                             padding: EdgeInsets.zero,
                             child: Text(
                               'Skip',
                               style: TextStyle(color: Colors.white70),
                             ),
                           )),
                     ),
                   ),
                 ),
                 Container(

                   width: size.width,
                   child: LayoutBuilder(builder:
                       (BuildContext context, BoxConstraints constraints) {
                     return Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SizedBox(
                             height: 50,
                           ),
                           MobileNumberWidget(constraints: constraints,textEditingControllerCallBack :(TextEditingController controller){
                               provider.textController=controller;
                           },dialcodeCallback: (String dialcode){
                             provider.dialcode=dialcode;
                           }),

                           GestureDetector(
                             onTap:(){
                          String err=  provider.validatePhoneNumber(  provider.textController.text);
                         if(err!=null){
                           provider.errMsg=err;
                           provider.isAnyError=true;
                               showErrorUsingSnackBar(err);
                         }else{
                           provider.login(provider.dialcode,  provider.textController.text,errFunction:showErrorUsingSnackBar );
                         }


                             },
                             child: Container(
                                 width: constraints.maxWidth * 0.85,
                                 height: 50,
                                 margin: EdgeInsets.only(top: 20),
                                 child: Align(

                                     child: ((){
                                       if(provider.isloading==true){
                                         return Container(
                                             height:16,
                                             width:16,
                                             child: CircularProgressIndicator(backgroundColor: Colors.white,
                                               valueColor: new AlwaysStoppedAnimation<Color>(Colors.black),
                                             )
                                         );
                                       }else{
                                      return   Text(
                                             "Send OTP",
                                             style:
                                             TextStyle(
                                             color: Colors.white, fontSize: 20));
                                       }

                                     }())

                                 ),
                                 decoration: BoxDecoration(
                                     color: Colors.black,
                                     borderRadius:
                                     BorderRadius.all(Radius.circular(7)))),
                           ),
                           Container(
                             padding: EdgeInsets.symmetric(
                                 horizontal: 20, vertical: 20),
                             width: constraints.maxWidth,
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment
                                   .spaceBetween,
                               children: [
                                 Container(
                                   width: (constraints.maxWidth/2) -40 ,
                                   height: 1,
                                   color: Colors.white38,
                                 ),
                                 Text(
                                   " OR ",
                                   style: TextStyle(color: Colors.white70),
                                 ),
                                 Container(
                                 width:  (constraints.maxWidth/2)-40 ,
                                   height: 1,
                                   color: Colors.white38,
                                 ),
                               ],
                             ),
                           ),
                           // email button
                           Container(
                             decoration: BoxDecoration(color: Colors.white,
                               borderRadius: BorderRadius.all(
                                   Radius.circular(7)),

                             ),
                             width: constraints.maxWidth * 0.85,
                             child: Padding(
                               padding: const EdgeInsets.all(10.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                 children: [
                                   Align(child: Icon(Icons.mail, size: 30,),
                                     alignment: Alignment.topLeft,
                                   ),
                                   Expanded(child: Text("Continue with Email",
                                     textAlign: TextAlign.center,
                                     style: TextStyle(fontSize: 20,
                                         fontWeight: FontWeight.w800),))
                                 ],
                               ),
                             ),
                           ),
// other social media
                           Container(
                             margin: EdgeInsets.only(top: 20),
                             width: constraints.maxWidth * 0.85,
                             child:
                             Row(children: [
                               Container(
                                 width:(constraints.maxWidth * 0.85)/2 -5,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(
                                       Radius.circular(7)),
                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment
                                         .start,
                                     children: [
                                       Align(child: SvgPicture.asset(
                                         'assets/images/facebook.svg',
                                         height: 25,),
                                         alignment: Alignment.topLeft,
                                       ),
                                       Expanded(child: Text("Facebook",
                                         textAlign: TextAlign.center,
                                         style: TextStyle(fontSize: 17,
                                             fontWeight: FontWeight.w800),))
                                     ],
                                   ),
                                 ),
                               ),
                             SizedBox(width: 10,),
                               Container(
                                 width:(constraints.maxWidth * 0.85)/2 -5,
                                 decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.all(
                                       Radius.circular(7)),

                                 ),
                                 child: Padding(
                                   padding: const EdgeInsets.all(10.0),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment
                                         .start,
                                     children: [
                                       Align(child: SvgPicture.asset(
                                         'assets/images/search.svg',
                                         height: 25,),
                                         alignment: Alignment.topLeft,
                                       ),
                                       Expanded(child: Text("Google",
                                         textAlign: TextAlign.center,
                                         style: TextStyle(fontSize: 17,
                                             fontWeight: FontWeight.w800),))
                                     ],
                                   ),
                                 ),
                               )
                             ],)
                             ,),
                           Container(
                             margin: EdgeInsets.only(top: 20, bottom: 20),
                             width: constraints.maxWidth * 0.85,
                             child: Expanded(
                               child: Text("By continuing you agree to our\n"
                                   "Terms of services Privacy Policy Content Policy",
                                 style: TextStyle(color: Colors.white),
                                 textAlign: TextAlign.center,
                               ),
                             ),
                           )

                         ]);
                   }),
                 )
               ],
             ),






           ],
         );
        }
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
