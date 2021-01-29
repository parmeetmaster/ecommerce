import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:model_architecture/api/SampleCall.dart';
import 'package:model_architecture/api/api_service.dart';

class SampleProvider extends ChangeNotifier{
  String responseData="Sample data";

  Dio dio=ApiService(baseOptions:  BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 10000,
    receiveTimeout: 10000,)).getclient();


  void sentOtp() async {

    Response resp = await SampleApi().requestSamplePost("9899");

    responseData=resp.data[0]["title"];

     notifyListeners();
  }


}