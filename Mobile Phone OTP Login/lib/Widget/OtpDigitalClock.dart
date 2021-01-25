


import 'package:flutter/material.dart';
import 'package:flutter_app_zomato_signin/Providers/OtpCountDownProvider.dart';
import 'package:provider/provider.dart';


class OtpDigitalClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OtpDigitalClockStateful();
  }
}



class OtpDigitalClockStateful extends StatefulWidget {
  @override
  _OtpDigitalClockState createState() => _OtpDigitalClockState();
}

class _OtpDigitalClockState extends State<OtpDigitalClockStateful> {
  @override
  Widget build(BuildContext context) {
        final otpCountDownProvider=  Provider.of<OtpCountDownProvider>(context);
    otpCountDownProvider.countDown(context);
    return   Consumer<OtpCountDownProvider>(
        builder: (context, value, child) {
          return   Text("0:${value.totalDurationinstr}",style: TextStyle(fontSize: 24));
        });
  }
}
