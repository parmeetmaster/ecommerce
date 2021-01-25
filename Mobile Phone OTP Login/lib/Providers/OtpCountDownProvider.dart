import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_app_zomato_signin/Providers/OtpScreenProvider.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';


class OtpCountDownProvider extends ChangeNotifier {
  int $totalDuration = 30;
  String totalDurationinstr='';
  bool iscountdownOn=true;
  bool istimerDone=false;
  countDown(BuildContext context) {
    final otpScreenProvider=  Provider.of<OtpScreenProvider>(context);
    if(iscountdownOn) {
      iscountdownOn=false;
      int endTime = DateTime
          .now()
          .millisecondsSinceEpoch + 1000 * 30;

      Timer.periodic(Duration(seconds: 1), (timer) {
        $totalDuration -= 1;
        if ($totalDuration < 10) {
          totalDurationinstr = '0${$totalDuration}';
        }
        else {
          totalDurationinstr = '${$totalDuration}'; /**/
        }

        if ($totalDuration <= 0) {
          totalDurationinstr='00';
          istimerDone=true;
          timer.cancel();
         otpScreenProvider.setResentToRed();/* its used to red color*/
        }
        notifyListeners();
      });
    }


  }


}