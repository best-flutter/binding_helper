import 'package:flutter/material.dart';

import 'dart:math' as Math;

import 'package:binding_helper/binding_helper.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

List<Color> colors = [
  Colors.green,
  Colors.yellowAccent,
  Colors.black12,
  Colors.greenAccent,
  Colors.redAccent
];

typedef void TapRect(Rect rect);

class RectGetter extends StatefulWidget {
  final Widget child;
  final TapRect tapRect;

  RectGetter({this.child, this.tapRect});

  @override
  State<StatefulWidget> createState() {
    return new _RectGetterState();
  }
}

class _RectGetterState extends State<RectGetter> {
  Rect _rect;

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        widget.tapRect(_rect);
      },
      behavior: HitTestBehavior.opaque,
      child: new RectProvider(
        child: widget.child,
        onGetRect: (Rect rect) {
          _rect = rect;
        },
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SecondPageState();
  }
}

class Item extends StatefulWidget {

  final int i;
  final double height;
  Item({
    this.i,
    this.height

});

  @override
  State<StatefulWidget> createState() {
    return new ItemState();
  }
}

class ItemState extends State<Item> {
  Rect _rect;

  @override
  Widget build(BuildContext context) {
    return new Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
          height: _rect?.height ?? 20.0,
          width: 20.0,
          color: widget.i%2==0 ? Colors.blueAccent : Colors.greenAccent,
        ),
        new RectProvider(
            child: new SizedBox(
              width: 100.0,
              height: widget.height,
              child: new Container(
                color: widget.i%2==0?Colors.redAccent:Colors.black12,
              ),
            ),
            onGetRect: (Rect rect) {
              if(_rect==null || _rect.width!=rect.width || _rect.height!=rect.height){
                setState(() {
                  _rect = rect;
                });
              }

            })
      ],
    );
  }
}

/// we draw a line with height of the text
class SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ListViewTest"),
      ),
      body: new ListView.builder(
          itemCount: 100,
          itemBuilder: (BuildContext c, int i) {
            return new Item(i:i,height: new Math.Random().nextInt(200).toDouble(),);
          }),
    );
  }
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey globalKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    List<Widget> list = [];
    for (int i = 0; i < 100; ++i) {
      list.add(
        new Container(
            color: colors[i % colors.length],
            child: new Padding(
              padding:
                  new EdgeInsets.all(new Math.Random().nextInt(10).toDouble()),
              child: new RectGetter(
                tapRect: (Rect rect) {
                  ScaffoldState state = globalKey.currentState;

                  state.showSnackBar(new SnackBar(
                      content: new SizedBox(
                    height: 30.0,
                    child: new Text(
                      "The rect is $rect",
                      style: new TextStyle(color: Colors.white),
                    ),
                  )));
                },
                child: new SizedBox(
                  height: 30.0 + new Math.Random().nextInt(70).toDouble(),
                  width: 30.0 + new Math.Random().nextInt(70).toDouble(),
                ),
              ),
            )),
      );
    }

    return new Scaffold(
      key: globalKey,
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new InkWell(
            child: new Padding(
              padding: new EdgeInsets.all(10.0),
              child: new Center(
                child: new Text("ListView"),
              ),
            ),
            onTap: () {
              Navigator.push(context,
                  new MaterialPageRoute(builder: (BuildContext context) {
                return new SecondPage();
              }));
            },
          )
        ],
      ),
      body: new Stack(
        children: <Widget>[
          new SingleChildScrollView(
            child: new Wrap(
              children: list,
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
