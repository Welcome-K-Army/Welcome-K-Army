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
    return MaterialApp(
      title: "Welcome K-Army",
      theme: ThemeData(primaryColor: Colors.blue),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appbar: AppBar(
            title: Text('welcome k-army'),
          ),
          body: TabBarView(
            children: [
              Text('홈 스크린'),
              Text('검색 스크린'),
              Text('마이 스크린'),
            ],
          ),
          bottomNavigationBar: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.home),
              text: 'Home',
            ),
            Tab(
              icon: Icon(Icons.search),
              text: 'Search',
            ),
            Tab(
              icon: Icon(,),
              text: 'My'
            )
          ]),
        )),
    );
  }
}
