import 'package:flutter/material.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/login/loginScreen.dart';
import 'package:Army/ui/signUp/signUpScreen.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
  //dd
    // final logo = Image.asset(
    //   "lib/image/Loading.gif",
    //   height: size.height / 4,
    // );

    return Scaffold(
      backgroundColor: Color(0xff0c9869),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            logo(),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Text(
                "Welcome!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: buttons(context,size),
            )
          ],
        ),
      ),
    );
  }

  Widget logo() {
    return Expanded(
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
  }

  Widget loginButton(BuildContext context,Size size) {
    return Material(
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
        onPressed: () => push(context, new LoginScreen()),
      ),
    );
  }

  Widget registerButton(BuildContext context,Size size) {
    return Material(
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
        onPressed: () => push(context, new SignUpScreen()),
      ),
    );
  }

  Widget buttons(BuildContext context, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton(context,size),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
          child: registerButton(context,size),
        ),
      ],
    );
  }
}
