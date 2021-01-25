

import 'package:flutter/material.dart';
import 'package:flutter_app_zomato_signin/Providers/LoginScreenProvider.dart';
import 'package:flutter_app_zomato_signin/support/code_country.dart';
import 'package:flutter_app_zomato_signin/support/country_list_pick.dart';
import 'package:provider/provider.dart';





class MobileNumberWidget extends StatefulWidget {
  BoxConstraints constraints;
  String dialcode;
  TextEditingController textController=new TextEditingController();

  final void Function(TextEditingController) textEditingControllerCallBack;
  final void Function(String) dialcodeCallback;
  MobileNumberWidget({@required this.constraints,@required this.textEditingControllerCallBack,@required this.dialcodeCallback
  });

  @override
  _MobileNumberWidgetState createState() => _MobileNumberWidgetState();
}

class _MobileNumberWidgetState extends State<MobileNumberWidget> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginProvider>(context);
    widget.textController.value=TextEditingValue(text: provider.phoneNumber);
    /* In future edit this get texteditor object from provider directly*/


    widget.textEditingControllerCallBack(widget.textController);
    BoxConstraints constraints=widget.constraints;
    return Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(color: Colors.white,
                border: Border.all(
                  color: Colors.red[500],
                ),
                borderRadius: BorderRadius.circular(10)

            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: constraints.maxWidth * 0.21,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                    padding: EdgeInsets.only(top: 5,bottom: 5,left: 5),
                    child: CountryListPick(
                      appBar: AppBar(
                        backgroundColor: Colors.amber,
                        title: Text('Country code'),
                      ),
                      theme: CountryTheme(
                        isShowFlag: true,
                        isShowTitle: false,
                        isShowCode: true,
                        isDownIcon: false,
                        showEnglishName: true,
                      ),
                      initialSelection: '+91',
                      onChanged: (CountryCode code) {
                        widget.dialcodeCallback(code.code);
                        print(code.name);
                        print(code.code);
                        print(code.dialCode);
                        print(code.flagUri);
                      },
                    ),
                  ),
                  Expanded(
                    child: Container(
                        height: 50,

                        padding: EdgeInsets.symmetric( vertical: 10),
                        child: TextField(
                          style: TextStyle(fontSize: 17),
                          autocorrect: true,
                          controller: widget.textController,
                          onChanged: (numberstr) {},
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(
                                left: 7, bottom: 4, right: 7),
                            hintText: ' Phone Number ',
                            hintStyle:
                            TextStyle(color: Colors.grey),
                           /* errorText: provider.errMsg!=""?provider.errMsg:"",*/

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(12.0)),
                              borderSide: BorderSide(
                                  color: Colors.white, width: 2),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Colors.grey[50]),
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),

        ]);
  }
}
