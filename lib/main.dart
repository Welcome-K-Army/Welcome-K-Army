import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyApp({this.TextInput});
  final Widget TextInput;
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  bool checkBoxValue = false;
  String actionText = "Default";
  @override
  Widget build(BuildContext ctxt) {
    return new MaterialApp(
      title: "Welcome K-Army",
      home: new Scaffold(
          appBar: new AppBar(title: new Text("Hello Flutter App"), actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.add_comment),
                onPressed: () {
                  setState(() {
                    actionText = "New Text";
                  });
                })
          ]),
          body: new Center(
            child: new Column(
              children: <Widget>[
                widget.TextInput,
                new Text(actionText),
                new Checkbox(
                    value: checkBoxValue,
                    onChanged: (bool newValue) {
                      setState(() {
                        checkBoxValue = newValue;
                      });
                    })
              ],
            ),
          )),
    );
  }
}
