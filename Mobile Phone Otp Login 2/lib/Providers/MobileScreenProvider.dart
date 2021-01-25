import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_happn_replica2/Constants.dart';
import 'package:flutter_app_happn_replica2/Services/ApiService.dart';

class MobileNumberInputProvider extends ChangeNotifier {
  static String phoneNumber = "kbs";
  static const phoneNumberExceed = "Phone Number Exceed Limit";
  static const defaultmsg="We need it to verify your account,and exclusively for that reason.It will never to shown on your profile.";
  static const RangeAcceptable =" "+defaultmsg;
  static const specialCharacternotallow = "Special Character are not allowed";
  final validCharacters = RegExp('[0-9]');
  final isContainSpecialCharacter=  RegExp(r'[!@#<>?":_`~;,[\]\\|=+)(*&^%\s-]');

  String validatePhoneNumber(String mobileNumberText) {

    /* Validation to check whether string contins special character or alphabets*/
      if (isContainSpecialCharacter.hasMatch(mobileNumberText) || !validCharacters.hasMatch(mobileNumberText)) {
        return specialCharacternotallow;
      }


      if (mobileNumberText.length > 10 && mobileNumberText.length < 14) {
      return RangeAcceptable;
    } else if (mobileNumberText.length > 14) {
      return phoneNumberExceed;
    }else if(mobileNumberText.length <10 ){
        return defaultmsg;
    }

    return RangeAcceptable;
  }

  refreshScreen() {
    notifyListeners();
  }

  Future<bool> login(String dialcode,String phoneNumber) async {

    try{
      final path = "$baseUrl/login/otp/send";
      final response = await ApiService.getInstance().getClient().post(
        path,
        data: {
          "phoneNumber": "$dialcode$phoneNumber",
        },
      );

      final data = response.data['data'];


      if (response.statusCode == 200) {
        print(data["sessionId"]);
        return true;
      } else {
        return false;
      }
    } on DioError catch(e){
      return false;
    }


    }

}
