import 'package:Army/ui/signUp/signUpScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:Army/constants.dart';
import 'package:Army/main.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/home/homeScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  GlobalKey<FormState> _key = new GlobalKey();
  GlobalKey<FormState> _forgotkey = new GlobalKey();
  TextEditingController _emailController = TextEditingController(); //email 컨트롤러
  TextEditingController _passwordController =
      TextEditingController(); //password 컨트롤러
  AutovalidateMode _validate = AutovalidateMode.disabled;
  AutovalidateMode _forgotvalidate = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<User> loginWithUserNameAndPassword() async {
      try {
        auth.UserCredential result = await auth.FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);
        DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore
            .collection(USERS)
            .doc(result.user.uid)
            .get();
        User user;
        if (documentSnapshot != null && documentSnapshot.exists) {
          user = User.fromJson(documentSnapshot.data());
          user.active = true;
          await FireStoreUtils.updateCurrentUser(user);
          hideProgress();
          MyAppState.currentUser = user;
        }
        return user;
      } on auth.FirebaseAuthException catch (exception) {
        hideProgress();
        switch ((exception).code) {
          case "invalid-email":
            showAlertDialog(
                context, '로그인할 수 없습니다.', '잘못된 이메일 형식입니다.');
            break;
          case "wrong-password":
            showAlertDialog(
                context, '로그인할 수 없습니다.', '비밀번호가 일치하지 않습니다.');
            break;
          case "user-not-found":
            showAlertDialog(context, '로그인할 수 없습니다.',
                '이메일이 존재하지 않습니다.\n회원가입을 진행해주세요.');
            break;
          case "user-disabled":
            showAlertDialog(
                context, '로그인할 수 없습니다.', '이 계정은 정지되었습니다. 관리자에게 문의해주시기 바랍니다.');
            break;
          case 'too-many-requests':
            showAlertDialog(context, '로그인할 수 없습니다.',
                '너무 많이 시도하셨습니다. 다시 시도해주시길 바랍니다.');
            break;
        }
        print(exception.toString());
        return null;
      } catch (e) {
        hideProgress();
        showAlertDialog(context, '로그인할 수 없습니다.',
            '로그인할 수 없습니다. 잠시 뒤 다시 시도해주세요.');
        print(e.toString());
        return null;
      }
    }

    login() async {
      if (_key.currentState.validate()) {
        // _key.currentState.save();
        showProgress(context, '로그인중입니다...', false);
        User user = await loginWithUserNameAndPassword();
        if (user != null)
          pushAndRemoveUntil(context, HomeScreen(user: user), false);
        else {
          setState(() {
            _validate = AutovalidateMode.onUserInteraction;
          });
        }
      }
    }

    void showSendEmailDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField =
                TextEditingController();
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              elevation: 3,
              backgroundColor: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: size.width / 1.1,
                height: size.height / 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text(
                        "회원가입한 이메일을 입력해주세요.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Form(
                        key: _forgotkey,
                        autovalidateMode: _forgotvalidate,
                        child: TextFormField(
                          controller: _emailControllerField,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                          cursorColor: Colors.black,
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(COLOR_PRIMARY), width: 2),
                              ),
                              hintText: "something@example.com",
                              labelText: "이메일",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black38,
                              )),
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xff0c9869),
                        child: MaterialButton(
                            minWidth: size.width / 2,
                            padding:
                                EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                            child: Text(
                              "이메일 보내기",
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: () async {
                              if (_forgotkey.currentState.validate()) {
                                try {
                                  auth.FirebaseAuth.instance
                                      .sendPasswordResetEmail(
                                          email: _emailControllerField.text);
                                  final snackBar = SnackBar(
                                    content: Text(
                                        "이메일을 확인해주세요."),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                setState(() {
                                  _forgotvalidate =
                                      AutovalidateMode.onUserInteraction;
                                });
                              }
                            }),
                      ),
                    )
                  ],
                ),
              ),
            );
          });
    }

    final node = FocusScope.of(context);

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(COLOR_PRIMARY), width: 2),
        ),
        labelText: "이메일",
        hintText: "something@example.com",
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
      ),
      //InputDecoration
      textInputAction: TextInputAction.next,
      validator: validateEmail,
      onEditingComplete: () => node.nextFocus(),
    ); //TextFormField 이메일

    final passwordField = TextFormField(
      obscureText: true,
      controller: _passwordController,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(COLOR_PRIMARY), width: 2),
        ),
        hintText: "비밀번호",
        labelText: "비밀번호",
        labelStyle: TextStyle(
          color: Colors.black87,

        ),
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
      ),
      textInputAction: TextInputAction.done,
      validator: validatePassword,
      onFieldSubmitted: (value) async {
        await login();
      },
    );

    final forgotPasswordField = Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "비밀번호찾기",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                    decoration: TextDecoration.underline
                  ),
                ),
                onPressed: () {
                  showSendEmailDialog(context);
                }),
            MaterialButton(
                child: Text(
                  "회원가입",
                  style: TextStyle(color: Colors.black, fontSize: 13, decoration: TextDecoration.underline),
                ),
                onPressed: () {
                  pushReplacement(context,SignUpScreen());
                }),
          ],
        )
      ],
    );
    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
          forgotPasswordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Color(COLOR_PRIMARY),
      child: MaterialButton(
        minWidth: size.width / 1.2,
        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
        child: Text(
          "로그인",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        ),
        onPressed: () async {
          await login();
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        loginButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
      body: Form(
        key: _key,
        autovalidateMode: _validate,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
          child: Container(
            height: size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Material(
                  elevation: 15.0,
                  borderRadius: BorderRadius.circular(300),
                  color: Colors.white,
                  child: Icon(
                    Icons.account_circle,
                    color: Color(COLOR_PRIMARY),
                    size: 250,
                  ),
                ),
                fields,
                Padding(
                  padding: EdgeInsets.only(bottom: 70),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
