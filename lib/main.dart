import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'mainView/mainView.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome k-army',
      theme: ThemeDate(primarycolor: Colors.blue),
      home: MainView(),
    );
  }
}
