import 'package:Army/constants.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:Army/main.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/auth/authScreen.dart';
import 'package:Army/ui/setting/profileScreen.dart';

class SettingScreen extends StatelessWidget {
  final User user;
  SettingScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Color(0xFFEDF0F4),
      child: Column(
        children: [
          SizedBox(height: 60),
          Stack(
            children: [
              Padding(padding: const EdgeInsets.fromLTRB(50,60,50,0),
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    elevation: 10,
                    child:Container(
                      width: double.infinity,
                      height: 150,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 75
                          ),
                          Text(user.nickName,style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold
                          ),),
                          SizedBox(height: 2,),
                          Text(user.email,style: TextStyle(
                              fontSize: 15,
                            color: Colors.black54
                          ),)
                        ],
                      ),
                    )
                ),),
              Align(
                child:Container(
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(COLOR_PRIMARY), width: 4),
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white
                  ),
                  child: user.profilePictureURL.isEmpty
                      ? Icon(
                    Icons.favorite,
                    size: 125,
                  )
                      : displayCircleImage(user.profilePictureURL, 125, false),
                ),
              )
            ],
          ),
          SizedBox(height: 15),
          Settings(
            //계정 수정 네비게이터
            icon: Icon(
              Icons.account_circle,
              color: Color(COLOR_PRIMARY),
            ),
            text: "계정 정보",
            press: () {
              push(context, ProfileScreen(user: user));
            },
          ),
          Settings(
            //도움말 네비게이터
              icon: Icon(
                Icons.help_outline,
                color: Color(COLOR_PRIMARY),
              ),
              text: "앱정보",
              press: () => showAboutDialog(
                context: context,
                applicationVersion: '1.1.0',
                applicationIcon: Icon(Icons.flutter_dash),
                applicationName: "켠김에 별까지",
                children:[
                  // ListTile(leading: Icon(Icons.flutter_dash), title: Text("1kl1"), subtitle: Text("Developer"),)
                  Text("병장 장성호 - Director & Developer", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14
                  ),),
                  Text("상병 나부겸 - Backend Developer", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14
                  ),),
                  Text("일병 신민석 - App Developer", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14
                  ),),
                  Text("일병 김민준 - UI/UX Designer & Developer", style: TextStyle(
                      color: Colors.black54,
                      fontSize: 14
                  ),),


                ]
              )),
          Settings(
            //로그아웃 네비게이터
              icon: Icon(
                Icons.logout,
                color: Color(COLOR_PRIMARY),
              ),
              text: "로그아웃",
              press: () async {
                user.active = false;
                user.lastOnlineTimestamp = Timestamp.now();
                FireStoreUtils.updateCurrentUser(user);
                await auth.FirebaseAuth.instance.signOut();
                MyAppState.currentUser = null;
                pushAndRemoveUntil(context, AuthScreen(), false);
              }),
        ],
      ),
    );
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
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.all(8),
          child: TextButton(
            onPressed: press,
            child: Row(
              children: [
                icon,
                SizedBox(width: 15),
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodyText1,
                  ), //Text
                ), //Expanded
                Icon(
                  Icons.east,
                  color: Color(COLOR_PRIMARY),
                )
              ],
            ), //Row
          ),
        ),
      ), //Card
    ); //Padding;
  }
}
