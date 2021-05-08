import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'joinOrLogin.dart';
import 'forgetPw.dart';
import 'package:firebase_auth_platform_interface/src/firebase_auth_exception.dart';
import 'dart:core';
import 'package:flutter/src/material/icons.dart';
import 'package:flutter/src/painting/edge_insets.dart';
import 'package:flutter/src/widgets/basic.dart';

enum Gender { MAN, WOMEN }

class LoginPage extends StatefulWidget {
  //UI변경은 StatefulWidget으로 설정
  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  Gender _gender = Gender.MAN;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _nickNameController = TextEditingController(); //nickName 컨트롤러
  final TextEditingController _emailController = TextEditingController(); //email 컨트롤러
  final TextEditingController _passwordController = TextEditingController(); //password 컨트롤러
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
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
              _LogoImage,
              //로그인 부
              Stack(
                children: <Widget>[
                  _inputForm(size),
                  _buttonLogin(size),
                ], //<Widget>
              ), //, Stack
              //하단 회원가입 연결 부
              Container(
                height: size.height * 0.05,
              ),
              Consumer<JoinOrLogin>(
                builder: (context, joinOrLogin, child) => GestureDetector(
                    onTap: () {
                      joinOrLogin.toggle();
                    },
                    child: Text(joinOrLogin.isJoin ? "Already have an Account?" : "Don't you have an Account?",
                        style: TextStyle(
                          color: joinOrLogin.isJoin ? Colors.red : Colors.green,
                        ))),
              ),
              Container(
                height: size.height * 0.05,
              ),
            ], //<Widget>[]
          ), //Column
        ], //<Widget>[]
      ), //Stack
    ); //Scaffold
  }

  //로그인 폼
  Widget _inputForm(Size size) {
    return Padding(
      padding: EdgeInsets.all(size.width * 0.05),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 32),
          child: Consumer<JoinOrLogin>(
              builder: (context, joinOrLogin, child) => Form(
                    key: _formkey,
                    child: joinOrLogin.isJoin ? _textFormJoin(size) : _textFormLogin(size),
                  ) //Form
              ),
        ), //Padding
      ), //Card
    ); //Padding
  }

  //로그인 텍스트 폼
  Widget _textFormLogin(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
            //이메일
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: "Email",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Email!";
              } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value.toString())) {
                //이메일 정규 표현식
                return "Not correct Email format";
              }
              return null;
            }), //TextFormField 이메일
        TextFormField(
            //패스워드
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              labelText: "Password",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Password!";
              } else if (value.length < 8) {
                return "Please enter a password of at least 8 digits!";
              }
              return null;
            }), //TextFormField 패스워드
        Container(
          height: 10,
        ),
        Consumer<JoinOrLogin>(
          builder: (context, value, child) => Opacity(
              opacity: value.isJoin ? 0 : 1,
              child: GestureDetector(
                  onTap: value.isJoin
                      ? null
                      : () {
                          goToForgetPw(context);
                        },
                  child: Text("Forgot Password"))),
        ),
      ], //Widget
    ); //Column
  }

  //회원가입 텍스트 폼
  Widget _textFormJoin(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
            //닉네임
            controller: _nickNameController,
            decoration: InputDecoration(
              icon: Icon(Icons.person_add),
              labelText: "NickName",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct NickName!";
              } else if (value == 0) {
                return "Not correct NickName format";
              }
              return null;
            }), //TextFormField 이메일
        TextFormField(
            //이메일
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.email),
              labelText: "Email",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Email!";
              } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value.toString())) {
                //이메일 정규 표현식
                return "Not correct Email format";
              }
              return null;
            }), //TextFormField 이메일
        Padding(
          padding: EdgeInsets.only(top: 10, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(right: 10), child: Icon(Icons.wc)),
              Container(
                child:SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    value: Gender.MAN,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = Gender.MAN;
                      });
                    },
                    child: Text("Male"),
                  ),
                ),
              ),
              Container(
                child:SizedBox(
                  height: 20,
                  width: 20,
                  child: Radio(
                    value: Gender.WOMEN,
                    groupValue: _gender,
                    onChanged: (value) {
                      setState(() {
                        _gender = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _gender = Gender.WOMEN;
                      });
                    },
                    child: Text("Female"),
                  ),
                ),
              ),
            ],
          ),
        ),
        TextFormField(
            //패스워드
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              labelText: "Password",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Password!";
              } else if (value.length < 8) {
                return "Please enter a password of at least 8 digits!";
              }
              return null;
            }), //TextFormField 패스워드
        TextFormField(
            //패스워드
            obscureText: true,
            controller: _passwordController,
            decoration: InputDecoration(
              icon: Icon(Icons.vpn_key),
              labelText: "Password Check",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Password!";
              } else if (value.length < 8) {
                return "Please enter a password of at least 8 digits!";
              }
              return null;
            }), //TextFormField 패스워드
        Container(
          height: 10,
        ),
        Consumer<JoinOrLogin>(
          builder: (context, value, child) => Opacity(
              opacity: value.isJoin ? 0 : 1,
              child: GestureDetector(
                  onTap: value.isJoin
                      ? null
                      : () {
                          goToForgetPw(context);
                        },
                  child: Text("Forgot Password"))),
        ),
      ], //Widget
    ); //Column
  }

  void goToForgetPw(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPw()));
  }

  //로그인 버튼
  Widget _buttonLogin(Size size) => Positioned(
        left: size.width * 0.15,
        right: size.width * 0.15,
        bottom: 0,
        child: SizedBox(
          height: 50,
          child: Consumer<JoinOrLogin>(
            builder: (context, joinOrLogin, child) => RaisedButton(
                child: Text(
                  joinOrLogin.isJoin ? "Sign Up" : "Sign In",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                color: joinOrLogin.isJoin ? Colors.red : Colors.green,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                onPressed: () {
                  if (_formkey.currentState.validate()) {
                    joinOrLogin.isJoin ? _register(context) : _login(context);
                  }
                }), //RaisedButton
          ),
        ), //SizedBox
      ); //Positioned

//상단부 이미지
  Widget get _LogoImage => Expanded(
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
  // FadeInImage.assetNetwork(
  //   placeholder:"image/Loading.gif",
  //   image: "https://lh3.googleusercontent.com/proxy/w1P2JMIYg4J5bSkZ594flSX5dvIxDkQ9rO8dgcGNzgOPxkOkJACiHXplqzmrVX584Uqnr6QX0IVqWK83DaB4LMsxzGNm_c8nKublP_uKmxgqmSPS9QZzs8z8-30uHa1i",
  // ),

  // 로그인 메서드
  void _login(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        final snackBar = SnackBar(
          content: Text("No user found for that email."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'wrong-password') {
        final snackBar = SnackBar(
          content: Text("Wrong password provided for that user."),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  // 계정생성 메서드

  void _register(BuildContext context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        final snackBar = SnackBar(
          content: Text("An account already exists for that email"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else if (e.code == 'operation-not-allowed') {
        final snackBar = SnackBar(
          content: Text("You cannot use this account"),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
    //스트림 빌더 안쓸경우 화면 전환 하는 방법
    //Navigator.push(context, MaterialPageRoute(builder:(context)=>MainPage(email:user.email));
  }
}
