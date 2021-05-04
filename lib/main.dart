import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'mainView/mainView.dart';
void main() => runApp(new MyApp());
// bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome K-Army",
      theme: ThemeData(primaryColor: Colors.blue),
      home: MainView(),
    );
  }
}