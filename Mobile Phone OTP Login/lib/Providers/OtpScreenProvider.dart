import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class OtpScreenProvider extends ChangeNotifier {

   bool istimerDone=false;
BuildContext context;
   /*Its called By OtpCountDown Provider to change states*/
   setResentToRed(){
    istimerDone=true;
    notifyListeners();

  }
  setContext(BuildContext mcontext){
     this.context=mcontext;
  }

   onCodeChange(String str) {
     if(str.characters.length==6){
       showLoaderDialog(context);
     }
   }

  onCodeSubmitted(String str) {
    if(str.characters.length==6){
    }

  }
   showLoaderDialog(context){
     if(context==null){
       print("Context Empty Dialog not generated");
       return;
     }

     AlertDialog alert=AlertDialog(
       content: Container(
         height:30,
         child: new Row(
           children: [
             CircularProgressIndicator(),
             Container(width: 10,),
             Container(margin: EdgeInsets.only(left: 7),child:Text("Verfying...",style: TextStyle(fontSize: 17), )),
           ],),
       ),
     );
     showDialog(barrierDismissible: false,
       context:context,
       builder:(BuildContext context){
         return alert;
       },
     );

   }

}
