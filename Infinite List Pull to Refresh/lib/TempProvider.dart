import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class TempModel{
  String name;
  String id;
  String createdAt;

  TempModel({this.id,this.name,this.createdAt});
}






class TempProvider extends ChangeNotifier {
  static int _count = 0;

  get getCount => _count;

  setCount() {
    _count++;
    notifyListeners();
  }

  Future<List<TempModel>> getTransaction(int pageno) async {
    List<TempModel> templist=[];

    Map<String, dynamic> map1 = {'createdAtFirstItem': "2020-12-07T12:55:26Z", 'pageNumber': pageno,};
    final url = "https://ktcf8oyj5h.execute-api.us-east-2.amazonaws.com/default/infinitescroll";
    try {
      Response response = await Dio().get(url,queryParameters: map1);
      List responseBody =await response.data;

      for(var item in responseBody){
        Map tempmap=item;
       TempModel m= TempModel(id:tempmap["id"].toString(),name:tempmap["name"].toString(),createdAt:tempmap["createdAt"].toString());
        templist.add(m);
      }


    } catch (e) {
      print(e);
    }
    return templist;
  }
}
