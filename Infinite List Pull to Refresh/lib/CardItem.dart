import 'package:flutter/material.dart';
import 'package:flutter_app_4/TempProvider.dart';
import 'package:provider/provider.dart';




class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
        @required this.animation,
        this.onTap,
        @required this.item,
        this.selected: false})
      : assert(animation != null),

        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final String item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.bodyText1;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return new Padding(
      padding: const EdgeInsets.all(2.0),
      child: new SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: new GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: new SizedBox(
            height: 128.0,
            child: new Card(
              color: Colors.amber,
              child: new Center(
                child: new Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
} //view