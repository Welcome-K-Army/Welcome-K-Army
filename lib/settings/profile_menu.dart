import 'package:flutter/material.dart';
import 'profile_edit.dart';
import '../model/user_data_model.dart';

class Profile_menu extends StatelessWidget {
  Profile_menu({this.userData});
  UserData userData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        const SizedBox(height: 25),
        ProfileMenu(
          //계정 수정 네비게이터
          icon: Icon(Icons.account_circle),
          text: "My Account",
          press: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()), arguments: widget.userData);
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
            press: () {
              print(widget.userData);
            }),
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
