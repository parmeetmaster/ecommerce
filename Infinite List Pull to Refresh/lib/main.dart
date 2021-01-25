import 'package:flutter/material.dart';
import 'package:flutter_app_4/CardItem.dart';
import 'package:flutter_app_4/TempProvider.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => TempProvider())],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(

          primarySwatch: Colors.blue,

          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<SliverAnimatedListState> _listKey =
  new GlobalKey<SliverAnimatedListState>();
  ListModel<String> _list;
  int _selectedItem;
  int _nextItem;
  RefreshController _refreshController = RefreshController();

  @override
  initState() {
    super.initState();
    _list = new ListModel<String>(
        listKey: _listKey,
        initialItems: [],
        removedItemBuilder: _buildRemovedItem,
        listtemp: _list
    );
// step 1 : add initial components to list
    Future<List<TempModel>> templist = TempProvider().getTransaction(0);
    templist.then((value) =>
    (() {
      for (var temp in value)
        _list.insert(_list.length, temp.name);
    }()));
  }

  Widget _buildRemovedItem(String item, BuildContext context,
      Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  Widget _buildItem(BuildContext context, int index,
      Animation<double> animation) {
    return new CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        if (mounted)
          setState(() {

          });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TempProvider>(builder: (context, tempProvider, _) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(""),
        ),
        body: SmartRefresher(

          child: CustomScrollView(
            slivers: <Widget>[
              SliverAnimatedList(
                key: _listKey,
                initialItemCount: _list.length,
                itemBuilder: _buildItem,

              )
            ],
          ),
          onRefresh: () async { // todo repair this area of removal
            setState(() {
/*              while(_list.length>=1) {
                for (int i = 0; i < _list.length; i++)
                  _list.removeAt(i);
              }*/
              int _tempsize = _list.length;

              for (int i = 0; i < _tempsize; i++)
                _list.removeAt(i);

              print("list size${_list.length}");
              /*_list.clearAll();*/
              print("list size${_list.length}");
            }
            );

            List<TempModel> templist = await TempProvider().getTransaction(0);
            setState(() {
              for (var temp in templist)
                _list.insert(_list.length, temp != null ? temp.name : "");
            });


            _refreshController.refreshFailed();
          },
          onLoading: () async {
            /*   await Future.delayed(Duration(milliseconds: 500));*/
            List<TempModel> templist = await TempProvider().getTransaction(0);
            setState(() {
              for (var temp in templist)
                _list.insert(_list.length, temp.name);
            });

            _refreshController.loadComplete();
          },
          enablePullUp: true,
          controller: _refreshController,
        ),
        // This trailing comma makes auto-formatting nicer for build methods.
      );
    }
    );
  }
}

class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
    ListModel<E> listtemp
  })
      : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = new List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<SliverAnimatedListState> listKey;
  final dynamic removedItemBuilder;
  List<E> _items;
  List<E> listtemp;

  SliverAnimatedListState get _sliverAnimatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _sliverAnimatedList.insertItem(index);
  }


  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
_sliverAnimatedList.c
      _sliverAnimatedList.removeItem(index,
              (BuildContext context, Animation<double> animation) {
            return removedItemBuilder(removedItem, context, animation);
          });
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);

}


