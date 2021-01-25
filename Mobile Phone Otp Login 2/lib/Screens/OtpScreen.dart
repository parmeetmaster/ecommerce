import 'package:flutter/material.dart';
import 'package:flutter_app_happn_replica2/EditedPackages/OtpPackages/otp_field.dart';
import 'package:flutter_app_happn_replica2/EditedPackages/OtpPackages/style.dart';
import 'package:flutter_app_happn_replica2/Providers/OtpScreenProvider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:sms_autofill/sms_autofill.dart';


import '../countrycodepackage/support/ConstantsVariables.dart';



class OtpScreen extends StatefulWidget {
  @override
  _OtpScreenState createState() => _OtpScreenState();
}


class _OtpScreenState extends State<OtpScreen> with CodeAutoFill  {
String otpcode;
@override
void initState() {
  _getAuthSignature();
  listenForCode();
  _listenOtp();
  super.initState();
}
Future<void> _getAuthSignature() async {
  String str= await SmsAutoFill().getAppSignature;
  print("app sign is $str");
}
Future<void>  _listenOtp() async{
  await SmsAutoFill().listenForCode;
}

@override
void codeUpdated() {

  setState(() {
    controller.setOtp("$code");
    print("otp is $otpcode");
    otpcode = code;
  });
}

OtpBlockController controller=new OtpBlockController();

  bool iscontinoueStatus = false;
   int _pinlength=6;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset : true,
        appBar: AppBar(),
        body: Consumer<OtpScreenProvider>(
            builder: (context, provider, child) {
              return LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Container(
                    height: constraints.maxHeight, width: constraints.maxWidth,
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
                                  Container(
                                    padding: EdgeInsets.only(top: 20,
                                        bottom: 20,
                                        left: 30,
                                        right: 30)
                                    , child: Center(
                                    child: Text(
                                      "Did you get your code?Enter it here!",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.openSans(fontSize: 20,
                                          color: HexColor(
                                              $mobileInputHeaderTitle),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 50,),
                                    child: OTPTextField(
                                      length: _pinlength,
                                      controller: controller,
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width,
                                      textFieldAlignment: MainAxisAlignment
                                          .spaceEvenly,
                                      fieldWidth: 40,
                                      fieldheight: 40,
                                      fieldStyle: FieldStyle.box,
                                      style: TextStyle(
                                          fontSize: 20
                                      ),
                                      onCompleted: (pin) {
                                        setState(() {
                                          iscontinoueStatus = true;
                                        });
                                      },
                                      uncomplete: () {
                                        if (iscontinoueStatus == true)
                                          setState(() {
                                            iscontinoueStatus = false;
                                          });
                                      },
                                    ),
                                  ),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                        "We need it to verify your account,and exclusively for that reason.It will never to shown on your profile."
                                        , textAlign: TextAlign.center,
                                        style: TextStyle(color: HexColor(
                                            $hexMobileInputbelowSubtitleColor)),
                                      )

                                  ),

                                ]),
                          ),
                          Expanded(
                            flex: 5,
                            child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  iscontinoueStatus ? Container(
                                    width: constraints.maxWidth * 0.7,
                                    child: RaisedButton(
                                      onPressed: () {},
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              80.0)),
                                      padding: EdgeInsets.all(0.0),
                                      child: Ink(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                              Color(0xff374ABE),
                                              Color(0xff64B6FF)
                                            ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                30.0)
                                        ),
                                        child: Container(
                                          constraints: BoxConstraints(
                                           minHeight: 50.0),
                                          alignment: Alignment.center,
                                          child: Text(
                                            "Continue",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                      : Container(
                                    height: 50,
                                    width: constraints.maxWidth * 0.7,
                                    child: FlatButton(
                                      onPressed: null,
                                      child: Text('Continue', style: TextStyle(
                                          fontSize: 17,
                                          color: HexColor("EBEBF0")
                                      )
                                      ),
                                      textColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: HexColor("EBEBF0"),
                                              width: 1,
                                              style: BorderStyle.solid
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              50)),
                                    ),
                                  )

                                ]),
                          ),
                          Expanded(
                              flex: 1,
                              child: Container()
                          ),
                        ]),

                  );
                }
              );
            } ),


      ),
    );


  }






}
