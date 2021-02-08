
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/constColors.dart';

class RoundedCornerImages extends StatelessWidget {

  Function onPress;
  String title,imageurl,price;

  RoundedCornerImages({this.onPress, this.title, this.imageurl, this.price}){
    title??="";
    imageurl??="";
    price??="";
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 188,
      height: 300,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 260,
            width: 180,
            child: ClipRRect(
                 borderRadius: BorderRadius.circular(20),
              child: Image.network(imageurl,
               fit: BoxFit.cover,
              ),
            ),
          ),
           Container(
             child: Padding(
               padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
               child: Container(
                 width: 180,
                 child: Row(children: [
                   Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),overflow: TextOverflow.ellipsis,),
                   Spacer(),
                   Text("\$${price}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17,color: projgrey),)

           ],),
               ),
             ),)
        ],
      ),
    );;
  }
}

class RoundedCornerImagesSmall extends StatelessWidget {

  Function onPress;
  String title,imageurl,price;

  RoundedCornerImagesSmall({this.onPress,this.imageurl}){
    imageurl??="";

  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 155,
      height: 240,
      margin: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Container(
            height: 200,
            width: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(imageurl,
                fit: BoxFit.cover,
              ),
            ),
          ),

        ],
      ),
    );;
  }
}