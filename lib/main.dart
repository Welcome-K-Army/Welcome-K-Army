import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'loginPage.dart';
import 'joinOrLogin.dart';
import 'Home.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: 
      //Splash(),
    ); //MaterialApp
  }
}

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User>(
      stream :FirebaseAuth.instance.authStateChanges(),
      builder: (context , snapshot){
        if(snapshot.data==null){
          return ChangeNotifierProvider<JoinOrLogin>.value(
            value: JoinOrLogin(), 
            child: LoginPage());//ChangeNotifierProvider
        }else{
          return MainPage(email:snapshot.data.email);
        }
      }
    );//SteamBuilder
  }
}

// 2021년 2월 23일 기준
// Authresult -> UserCredential
// FirebaseUser -> User

// main.dart  파일 수정
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// StreamBuilder 부분
// stream: FirebaseAuth.instance.authStateChanges()
