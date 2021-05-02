import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

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
                FadeInImage.assetNetwork(
                  placeholder:"assets/Loding.gif",
                  image: "https://lh3.googleusercontent.com/proxy/w1P2JMIYg4J5bSkZ594flSX5dvIxDkQ9rO8dgcGNzgOPxkOkJACiHXplqzmrVX584Uqnr6QX0IVqWK83DaB4LMsxzGNm_c8nKublP_uKmxgqmSPS9QZzs8z8-30uHa1i",
                ),
          //로그인 부
                Stack(
                  children: <Widget>[
                    _inputForm(),
                    _buttonLogin(),
                  ],//<Widget>
                ), //, Stack
          //하단 회원가입 연결 부
                Container(
                  height: 40,
                ),
                Text("Don't Have an Account?"),
                Container(
                  height: 20,
                )
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ); //Scaffold
  }

  Widget _inputForm(){
    return  Padding(
      padding: EdgeInsets.all(12),
      child:Card(
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(16)
        ),
        elevation:6,
        child:Padding(
          padding: EdgeInsets.only(left:12,right:12,top:12,bottom:32 ),
          child:Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
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
    );//Padding
  }

  Widget _buttonLogin() => Positioned(
    left: 32,
    right:32,
    bottom:0,
    child:RaisedButton(
      child: Text("Login"),
      color: Colors.green,
      height:20,
      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(15)
      ),
      onPressed:(){

      }
    ),//RaisedButton
  );//Positioned
}
