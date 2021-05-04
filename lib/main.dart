import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'mainView/mainView.dart';

//bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class MyApp extends StatefulWidget {
  MyAppState createState() => new MyAppState();
}

//Bottom Tab으로 구성된 MainView, View 추가시 length 값 변경 및 body의 TabBarView에 생성자 추가할 것
class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp()(
      title: 'welcome k army',
      theme: ThemeData(primarycolor: Colors.blue),
      home: MainView(),
    );
  }
}
