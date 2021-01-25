import 'package:flutter/material.dart';
import 'package:flutter_app_happn_replica2/Providers/MobileScreenProvider.dart';
import 'package:flutter_app_happn_replica2/Screens/OtpScreen.dart';
import 'package:flutter_app_happn_replica2/countrycodepackage/support/code_country.dart';
import 'package:flutter_app_happn_replica2/countrycodepackage/support/country_list_pick.dart';

import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../countrycodepackage/support/ConstantsVariables.dart';

class MobileVerificationScreen extends StatefulWidget {
  @override
  _MobileVerificationScreenState createState() =>
      _MobileVerificationScreenState();
}

class _MobileVerificationScreenState extends State<MobileVerificationScreen> {
  int iscontinoueStatus = 0;
  TextEditingController _phnocontroller = new TextEditingController();
  String below_phno_text = MobileNumberInputProvider.RangeAcceptable;
  bool _err = false;
String _dialcode="+1";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(),
        body: Consumer<MobileNumberInputProvider>(
          builder: (context, provider, child) {
            return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return Container(
                  height: constraints.maxHeight,
                  width: constraints.maxWidth,
                  color: Colors.white,
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 8,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "What's your phone Number?",
                                  style: GoogleFonts.openSans(
                                      fontSize: 18,
                                      color: HexColor($mobileInputHeaderTitle),
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  children: [
                                    Container(
                                        height: 50,
                                        width: constraints.maxWidth * 0.04),
                                    Container(
                                      height: 50,
                                      width: constraints.maxWidth * 0.25,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[50],
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: EdgeInsets.all(5),
                                      child: CountryListPick(
                                        appBar: AppBar(
                                          backgroundColor: Colors.amber,
                                          title: Text('Country code'),
                                         ),
                                          theme: CountryTheme(
                                          isShowFlag: true,
                                          isShowTitle: false,
                                          isShowCode: true,
                                          isDownIcon: false,
                                          showEnglishName: true,
                                        ),
                                        initialSelection: '+1',
                                        onChanged: (CountryCode code) {
                                          _dialcode=code.dialCode;
                                          print(code.name);
                                          print(code.code);
                                          print(code.dialCode);
                                          print(code.flagUri);
                                        },
                                      ),
                                    ),
                                    Container(
                                        height: 70,
                                        width: constraints.maxWidth * 0.7,
                                        padding: EdgeInsets.all(10),
                                        child: TextField(
                                          style: TextStyle(fontSize: 20),
                                          controller: _phnocontroller,
                                          autocorrect: true,
                                          onChanged: (numberstr) {
                                            below_phno_text = provider
                                                .validatePhoneNumber(numberstr);
                                            if (below_phno_text == MobileNumberInputProvider.RangeAcceptable) {
                                              iscontinoueStatus = 1;
                                            }else{
                                              iscontinoueStatus = 0;
                                            }
                                                  provider.refreshScreen();
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                                left: 7, bottom: 4, right: 7),
                                            hintText:
                                                'Enter Phone Number Please',
                                            hintStyle:
                                                TextStyle(color: Colors.grey),
                                            filled: true,
                                            fillColor: Colors.grey[50],
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(12.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[50],
                                                  width: 2),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide: BorderSide(
                                                  color: Colors.grey[50]),
                                            ),
                                          ),
                                        )),
                                  ],
                                ),
                                Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "$below_phno_text",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: _err
                                              ? Colors.red
                                              : HexColor(
                                                  $hexMobileInputbelowSubtitleColor)),
                                    )),
                              ]),
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [(){
                                if(iscontinoueStatus==0){
                                  return Container(
                                    height: 50,
                                    width: constraints.maxWidth * 0.7,
                                    child: FlatButton(
                                      onPressed: null,
                                      child: Text('Continue',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: HexColor("EBEBF0"))),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: HexColor("EBEBF0"),
                                              width: 1,
                                              style: BorderStyle.solid),
                                          borderRadius:
                                          BorderRadius.circular(50)),
                                    ),
                                  );
                                }else if(iscontinoueStatus==1){
                                  return Container(
                                    width: constraints.maxWidth * 0.7,
                                    child: RaisedButton(
                                      onPressed: () async {
                                        iscontinoueStatus=2;
                                        provider.refreshScreen();
                                        String res =
                                        provider.validatePhoneNumber(
                                            _phnocontroller.text);
                                        below_phno_text = res;

                                        if(res==MobileNumberInputProvider.RangeAcceptable)
                                        {
                                          if(await provider.login(_dialcode,_phnocontroller.text) == true){
                                            _err=false;
                                            below_phno_text="Code Sent Successful";
                                            iscontinoueStatus=1;
                                            provider.refreshScreen();
                                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen()));

                                          }else {
                                            below_phno_text="Oops! The format of your number is incorrect Please check that you have entered a valid number.";
                                            _err=true;
                                            iscontinoueStatus=1;
                                            provider.refreshScreen();
                                          }

                                        }
                                        provider.refreshScreen();
                                      },
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(80.0)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(0xff374ABE),
                                                Color(0xff64B6FF)
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(
                                                30.0)),
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth: 300.0,
                                              minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }else if(iscontinoueStatus==2){
                                  return Container(
                                    height:22,
                                    width: 22,
                                    child: CircularProgressIndicator(),
                                  );
                                }

                              }(),

                              ]),
                        ),
                        Expanded(flex: 1, child: Container()),
                      ]),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
