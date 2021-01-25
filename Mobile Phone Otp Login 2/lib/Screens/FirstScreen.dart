import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_happn_replica2/Services/preference.dart';
import 'package:flutter_app_happn_replica2/provider/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_app_happn_replica2/Screens/MobileNumberInputScreen.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
class FirstScreenWrappper extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}



class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {


double $commonfontsize=15;

  @override
  Widget build(BuildContext context) {
    var totalwidth = MediaQuery.of(context).size.width;
    var totalheight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: totalheight*0.08, width: totalwidth),
            Container(
                alignment: Alignment.topLeft,
                height: totalheight * 0.1,
                width: totalheight * 0.1,
                child: Image.asset('assets/images/logo+demo.png')),
            Container(height: 25, width: totalwidth),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 40,right: 20),
          /*    width: totalwidth,
                height:totalheight*0.37,*/
                child: FittedBox(
                  fit: BoxFit.fitHeight,
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Find the\npeople \n"
                    "you've \ncrossed\npaths with",
                    style: TextStyle(
                        color: Colors.white,

                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
           SizedBox( height: totalheight*0.07),
            Container(
              width: totalwidth,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                //google button
                  Container(
                    width: totalwidth*0.8,
                    height: 45,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () async {
                      await  GoogleSignInProvider().login(context);

                      },
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container( padding:EdgeInsets.all(10),child: Image.asset('assets/images/googleimg.png',fit: BoxFit.fill)),
                            Text(
                              'Continue with Google    ',
                              style: TextStyle(
                                fontSize:  $commonfontsize,
                                fontWeight: FontWeight.w700,
                                color:  Theme.of(context).accentColor,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),// google container
                  SizedBox(height: 15,),
              // facebook button
                  Container(
                    width: totalwidth*0.8,
                    height: 45,
                    child: RaisedButton(
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                      onPressed: () {
                      },
                      color: HexColor("#0087B4"),
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Container( padding:EdgeInsets.all(10),
                                child: Image.asset('assets/images/facebook.png',fit: BoxFit.fill)),
                            Text(
                              'Continue with Facebook',
                              style: TextStyle(
                                fontSize: $commonfontsize,
                                fontWeight: FontWeight.w700,
                                color:  Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15,),
                  //phone verification container
                  Container(
                    width: totalwidth*0.8,
                    height: 45,
                    child: GestureDetector(
                      onTap: () {
                        print("Extended clicked");
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MobileVerificationScreen()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Center(
                              child: Text(
                                "Use my Phone Number",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Montserrat',
                                  fontSize: $commonfontsize,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox( height: 33,),
                  Container(
                    height: 33,
                    padding: EdgeInsets.symmetric(horizontal: totalwidth*0.05),
                  child:FittedBox(
                    child: Text.rich(
                        TextSpan(text:"",
                       children: <TextSpan>[
                      TextSpan(text:"By registering you agreed ",style: TextStyle(color: Colors.white)),
                      TextSpan(text: "Terms of Service",style: TextStyle(color: Colors.white,decoration: TextDecoration.underline))
                         ,TextSpan(text: " and \n ",style: TextStyle(color: Colors.white)),
                          TextSpan(text: "Privacy Policy",style: TextStyle(color: Colors.white,decoration: TextDecoration.underline))
                        ]
                    ),
                      textAlign: TextAlign.center,
                    ),
                  ) ,
                  ),
                  SizedBox(height: 25,),
                  Container(padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 15,
                    child:FittedBox(
                      child: Text.rich(
                        TextSpan(text:"",
                            children: <TextSpan>[
                              TextSpan(text: "Recover my account",style: TextStyle(fontWeight:FontWeight.bold,color: Colors.white,decoration: TextDecoration.underline))
                            ]
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ) ,
                  ),
                  SizedBox(height: 33,),
                ],
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
          0.0,
          1.0
        ], colors: [
          HexColor("#0090BA"),
          HexColor("#00B6D2"),
        ])),
      ),
    );
  }

  @override
  void initState() {
    Preference.load(); //its starts prefereneces at begin of app
    super.initState();
  }
}
