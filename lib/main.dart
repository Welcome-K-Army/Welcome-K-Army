import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants.dart';

import './mainView/mainView.dart';
import './calendarView/provider/event_provider.dart';

void main() { runApp(MyApp()); }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EventProvider>(
      create: (context) => EventProvider(),
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'welcome k army',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ), // ThemeData
      home: MainView(),
      )
    ); // MaterialApp
  }
}
