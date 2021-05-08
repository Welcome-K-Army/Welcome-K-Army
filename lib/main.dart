import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'mainView/mainView.dart';

void main() => runApp(new MyApp());

//bottomNavigationBar는 항상 내용 재구성 해야되서 Stateful로 구성
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome k army',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity(),
      ),
      home: MainView(),
    )
  }
}
