import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';
import 'joinOrLogin.dart';

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
