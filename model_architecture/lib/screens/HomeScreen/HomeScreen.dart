import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:model_architecture/constantPackage/constColors.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/constantPackage/language/words.dart';
import 'package:model_architecture/providers/SampleProvider.dart';
import 'package:model_architecture/screens/HomeScreen/Components/CatagoryButton.dart';
import 'package:model_architecture/utils/Globals.dart';
import 'package:model_architecture/utils/languageDeligate.dart';
import 'package:provider/provider.dart';

import 'Components/CornerImages.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottomOpacity: 0.0,
        elevation: 0.0,
        leading: Padding(
          padding: EdgeInsets.all(10),
          child: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://images.all-free-download.com/images/graphicthumb/thailand_girl_205433.jpg')),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 10, right: 15),
            child: Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 5, right: 6),
                    child: Icon(
                      Icons.shopping_cart,
                      color: projblack,
                    )),
                Positioned(
                    left: 12,
                    top: 0,
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                          color: projpink, shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        "2",
                        style: TextStyle(fontSize: 10, color: projblack),
                      )),
                    ))
              ],
            ),
          ),
        ],
      ),
      body: Consumer<SampleProvider>(builder: (context, value, child) {
        final sampleprovider = Provider.of<SampleProvider>(context);
        return SafeArea(
            child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _getCategory(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RoundedCornerImages(
                    price: "28",
                    title: "woolean coat",
                    imageurl:
                        "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  ),
                  RoundedCornerImages(
                    imageurl:
                        "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  )
                ],
              ),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(Globals.primaryLanguage.recommandForYou,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600)))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  RoundedCornerImagesSmall(
                    imageurl:
                    "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  ),
                  RoundedCornerImagesSmall(
                    imageurl:
                    "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  ),
                  RoundedCornerImagesSmall(
                    imageurl:
                    "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  ),
                  RoundedCornerImagesSmall(
                    imageurl:
                    "https://i.pinimg.com/originals/ca/76/0b/ca760b70976b52578da88e06973af542.jpg",
                  ),
                ],
              ),
            ),
          ],
        ));
      }),
    );
  }

  _getCategory() {
    final list = ["Coat", "Dresses", "jersy", "Pants"];
    List<Widget> widgetlist = [];
    for (String text in list) {
      widgetlist.add(CategoryButton(
        text: text,
        onPress: () {
          print("its working");
        },
      ));
      widgetlist.add(SizedBox(
        width: 8,
      ));
    }
    return widgetlist;
  }
}
