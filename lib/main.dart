import 'package:flutter/material.dart';

import 'constants.dart';

import './mainView/mainView.dart';

import 'analysisView/analysisData.dart';

void main() { runApp(MyApp()); }

class MyApp extends StatelessWidget {
  AnalysisData(type: AnalysisType.principal);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'welcome k army',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), // ThemeData
      home: MainView(),
    ); // MaterialApp
  }
}