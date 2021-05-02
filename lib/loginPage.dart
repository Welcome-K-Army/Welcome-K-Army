import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return 
    Scaffold(
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
          //상단 이미지 부
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
          //로그인 부
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12),
                      child:Card(
                        elevation:6,
                        child:Padding(
                          padding:const EdgeInsets.symmetric(horizontal: 12,top:12,bottom:32 ),
                          child:Form(
                            key: _formkey,
                            child: Column(
                              children: <Widget>[
                              TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(icon:Icon(Icons.account_circle),
                                labelText:"Email",
                                ),
                              ),//TextFormField 이메일 바
                              TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(icon:Icon(Icons.vpn_key),
                                labelText:"Password",
                                ),
                              ),//TextFormField 패스워드 바
                              Text("Forgot Password"),
                              ]//Widget
                            )//Column
                          ),//Form
                        ),//Padding
                      ),//Card
                    ),
                  ],//Widget
                ), ////<Widget>[], Stack
          //하단 회원가입 연결 부
                Text("Don't Have an Account?"),
                Container(
                  height: 12,
                )
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ); //Scaffold

  }
}
