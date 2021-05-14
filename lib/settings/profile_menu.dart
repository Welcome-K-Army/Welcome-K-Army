import 'package:flutter/material.dart';

class Profile_menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        SizedBox(height: 25),
        ProfileMenu(
          //계정 수정 네비게이터
          icon: Icon(Icons.account_circle),
          text: "My Account",
          press: () {
            //Navigator.push(context,MaterialPageRoute(builder:(context) => EditProfile()));//currentOnlineUserId넘겨줘야됨
          },
        ),
        ProfileMenu(
            //관심 직책 네비게이터
            icon: Icon(Icons.library_books),
            text: "관심직책",
            press: () {}),
        ProfileMenu(
            //도움말 네비게이터
            icon: Icon(Icons.help_outline),
            text: "help",
            press: () {}),
        ProfileMenu(
            //로그아웃 네비게이터
            icon: Icon(Icons.logout),
            text: "Logout",
            press: () {}),
      ],
    ); //Column;
  }
}
