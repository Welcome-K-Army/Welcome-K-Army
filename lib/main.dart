import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'loginPage.dart';
import 'joinOrLogin.dart';
import 'Home.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider<JoinOrLogin>.value(
          value: JoinOrLogin(), 
          child: LoginPage())//ChangeNotifierProvider
      //Splash(),
    ); //MaterialApp
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SteamBuilder<FirebaseUser>(
      steam :FirebaseAuth.instance.onAuthStateChanged,
      builder: (context , snapshot){
        if(snapshot.data==null){
        return ChangeNotifierProvider<JoinOrLogin>.value(
          value: JoinOrLogin(), 
          child: LoginPage());//ChangeNotifierProvider
        }else{
          return MainPage(snapshot.data.email);
        }
      }
    );//SteamBuilder
  }
}