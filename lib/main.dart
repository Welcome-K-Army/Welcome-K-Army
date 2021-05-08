import 'package:flutter/material.dart';
import 'package:./constants.dart'

import './mainView/mainView.dart';

void main() { runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'welcome k army',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), // ThemeData
      home: MainView(),
    ); // MaterialApp
  }
}