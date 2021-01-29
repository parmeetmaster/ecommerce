import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:model_architecture/api/SampleCall.dart';
import 'package:model_architecture/api/api_service.dart';

class SampleProvider extends ChangeNotifier{
  Dio dio=ApiService(baseOptions:  BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 10000,
    receiveTimeout: 10000,)).getclient();


  void sentOtp() async {
  try {
    Response resp = await SampleApi().sentOtp("9899");
     print(resp.data);
    }on DioError catch(e){
    }

  }


}