import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    final TextEditingController _emailController=TextEditingController();
    final TextEditingController _passwordController=TextEditingController();
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
                Stack(
                  children: <Widget>[
                    Form(
                      key: _formkey,
                      child:Column(
                        children: <Widget>[
                          TextFormField(),
                          TextFormField(),
                          Text("Forgot Password"),
                        ],//<Widget>[]
                      )),//Column,Form
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.black,
                    ),
                  ],
                ), ////<Widget>[], Stack
                Text("Don't Have an Account?"),
                Container(
                  height: size.height*0.05,
                )
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ), //Scaffold
    ); //MaterialApp
  }
}
