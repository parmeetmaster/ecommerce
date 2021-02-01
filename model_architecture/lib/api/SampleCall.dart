import 'package:dio/dio.dart';
import 'package:model_architecture/api/api_service.dart';

class SampleApi{

  Dio dio=ApiService(baseOptions:  BaseOptions(
    baseUrl: "https://jsonplaceholder.typicode.com",
    connectTimeout: 10000,
    receiveTimeout: 10000,)).getclient();

Future<Response>  requestSamplePost(String phno) async{

   return dio.get("/posts");
  }



}