import 'package:flutter/material.dart';
import 'profile_edit.dart';


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
            Navigator.push(context,MaterialPageRoute(builder:(context) => EditProfile()));//currentOnlineUserId넘겨줘야됨
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

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    Key key,
    @required this.text, //@required은 기본값이 없고 null이 아닐경우에 사용/
    @required this.icon, 
    @required this.press,
  }) : super(key: key); //기본생성자 호출

  final String text;
  final Icon icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child:Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
              elevation: 5,
              child:FlatButton(
              padding: EdgeInsets.all(20),
              
              color: Color(0xFFF5F6F9),
              onPressed : press,
              child:Row(
                children:[
                  icon,
                  SizedBox(width: 20),
                  Expanded(
                    child:Text(
                      text,
                      style: Theme.of(context).textTheme.bodyText1,
                      
                    ),//Text
                  ),//Expanded
                  Icon(Icons.east)
                ],
              ),//Row
            ),//FlatButton
          ),//Card

        );//Padding;
  }
}
