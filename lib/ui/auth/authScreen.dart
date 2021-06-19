import 'package:Army/constants.dart';
import 'package:flutter/material.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/login/loginScreen.dart';
import 'package:Army/ui/signUp/signUpScreen.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // final logo = Image.asset(
    //   "lib/image/Loading.gif",
    //   height: size.height / 4,
    // );
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Container(
        decoration: BoxDecoration(
          // image: DecorationImage(
          //   image: AssetImage("assets/images/bulb.jpg"),
          //   fit: BoxFit.cover,
          // ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              logo(),
              Padding(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: buttons(context, size)
                ) ,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget logo() {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.only(top: 0, left: 24, right: 24),
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(bottom: 50, top: 15),
                  child: Column(children: [
                    Icon(
                      Icons.flutter_dash,
                      color: Color(COLOR_PRIMARY),
                      size: 65,
                    ),
                    Text("켠김에 별까지")
                  ])),
               Material(
                 elevation: 15.0,
                 borderRadius: BorderRadius.circular(300),
                 color:Colors.white,
                 child: Icon(
                   Icons.account_circle,
                   color: Color(COLOR_PRIMARY),
                   size: 250,
                 ),
               )
            ],
          )),
    );
  }

  Widget loginButton(BuildContext context, Size size) {
    return Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Color(COLOR_PRIMARY),
      child: MaterialButton(
        minWidth: size.width / 1.2,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        child: Text(
          "로그인",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        onPressed: () => push(context, new LoginScreen()),
      ),
    );
  }

  Widget registerButton(BuildContext context, Size size) {
    return Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Color(0xff05B047),
      child: MaterialButton(
        minWidth: size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "회원가입",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        onPressed: () => push(context, new SignUpScreen()),
      ),
    );
  }

  Widget buttons(BuildContext context, Size size) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      verticalDirection: VerticalDirection.down,
      children: <Widget>[
        loginButton(context, size),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 25, 0, 10),
          child: registerButton(context, size),
        ),
      ],
    );
  }
}
