import 'package:flutter/material.dart';
import 'loginPage.dart';
import 'package:provider/provider.dart';
import 'data/join_or_login.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<JoinOrLogin>.value(
        value: JoinOrLogin(), 
        child:LoginPage(),
      ),//ChangeNotifierProvider
    ); //MaterialApp
  }
}
