import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/routes.dart';

class OpeningView extends StatefulWidget {
  @override
  OpeningViewState createState() => OpeningViewState();
}

class OpeningViewState extends State<OpeningView> {
  OpeningViewState();

  String nickName="";

  

  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // final logo = Image.asset(
    //   "lib/image/Loading.gif",
    //   height: size.height / 4,
    // );
    final logo = Expanded(
      child: Padding(
        padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
        child: FittedBox(
          fit: BoxFit.contain,
          child: CircleAvatar(
            minRadius: 40,
            backgroundImage: AssetImage("lib/image/Loading.gif"),
          ), //CircleAvatar
        ), //FittedBox
      ), //Padding
    ); //Expanded

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authLogin);
        },
      ),
    );

    final registerButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.white,
      child: MaterialButton(
        minWidth: size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "Register",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.authRegister);
        },
      ),
    );

    final buttons = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
          child: registerButton,
        ),
      ],
    );

    display() {
      if (nickName != null)
        return Text(
          "Welcome back $nickName!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
      else
        return Text(
          "Welcome!",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        );
    }

    return Scaffold(
      backgroundColor: Color(0xff0c9869),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: display(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 40, bottom: 40),
              child: buttons,
            )
          ],
        ),
      ),
    );
  }
}
