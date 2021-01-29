
import 'package:flutter/material.dart';
import 'package:model_architecture/constantPackage/language/languageEn.dart';
import 'package:model_architecture/providers/SampleProvider.dart';
import 'package:provider/provider.dart';

class SampleScreen extends StatefulWidget {
  @override
  _SampleScreenState createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(""),
      ),
      body: Consumer<SampleProvider>(
          builder: (context, value,child) {
            final   sampleprovider=  Provider.of<SampleProvider>(context);
            return Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
               Text("${sampleprovider.responseData}"),
                  RaisedButton(
                    onPressed:sampleprovider.sentOtp,
                    color: Colors.blueAccent,
                    child: Text('LoadData',
                      style:TextStyle(color: Colors.red),

                    ),
                  ),
                ],
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
