import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:Army/main.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/auth/authScreen.dart';

class SettingScreen extends StatelessWidget {
  final User user;
  SettingScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const SizedBox(height: 25),
        Settings(
          //계정 수정 네비게이터
          icon: Icon(Icons.account_circle),
          text: "My Account",
          press: () {
            push(context,ProfileScreen(user:user));
          },
        ),
        Settings(
            //관심 직책 네비게이터
            icon: Icon(Icons.library_books),
            text: "관심직책",
            press: () {}),
        Settings(
            //도움말 네비게이터
            icon: Icon(Icons.help_outline),
            text: "help",
            press: () {}),
        Settings(
            //로그아웃 네비게이터
            icon: Icon(Icons.logout),
            text: "Logout",
            press: () async {
              user.active = false;
              user.lastOnlineTimestamp = Timestamp.now();
              FireStoreUtils.updateCurrentUser(user);
              await auth.FirebaseAuth.instance.signOut();
              MyAppState.currentUser = null;
              pushAndRemoveUntil(context, AuthScreen(), false);
            }),
      ],
    ); //Column;
  }
}

class Settings extends StatelessWidget {
  const Settings({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
  }) : super(key: key);

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        elevation: 5,
        child: FlatButton(
          padding: EdgeInsets.all(20),
          color: Color(0xFFF5F6F9),
          onPressed: press,
          child: Row(
            children: [
              icon,
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                ), //Text
              ), //Expanded
              Icon(Icons.east)
            ],
          ), //Row
        ), //FlatButton
      ), //Card
    ); //Padding;
  }
}
