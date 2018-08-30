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
