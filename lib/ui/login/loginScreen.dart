
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
  TextEditingController _passwordController = TextEditingController(); //password 컨트롤러
  AutovalidateMode _validate = AutovalidateMode.disabled;
  AutovalidateMode _forgotvalidate = AutovalidateMode.disabled;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Future<User> loginWithUserNameAndPassword() async {
      try {
        auth.UserCredential result = await auth.FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailController.text, password: _passwordController.text);
        DocumentSnapshot documentSnapshot = await FireStoreUtils.firestore.collection(USERS).doc(result.user.uid).get();
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
            showAlertDialog(context, 'Couldn\'t Authenticate', 'malformedEmail');
            break;
          case "wrong-password":
            showAlertDialog(context, 'Couldn\'t Authenticate', 'Wrong password');
            break;
          case "user-not-found":
            showAlertDialog(context, 'Couldn\'t Authenticate', 'No user corresponds to this email');
            break;
          case "user-disabled":
            showAlertDialog(context, 'Couldn\'t Authenticate', 'This user is disabled');
            break;
          case 'too-many-requests':
            showAlertDialog(context, 'Couldn\'t Authenticate', 'Too many requests, Please try again later.');
            break;
        }
        print(exception.toString());
        return null;
      } catch (e) {
        hideProgress();
        showAlertDialog(context, 'Couldn\'t Authenticate', 'Login failed. Please try again.');
        print(e.toString());
        return null;
      }
    }

    login() async {
      if (_key.currentState.validate()) {
        // _key.currentState.save();
        showProgress(context, 'Logging in, please wait...', false);
        User user = await loginWithUserNameAndPassword();
        if (user != null) pushAndRemoveUntil(context, HomeScreen(user: user), false);
      } else {
        setState(() {
          _validate = AutovalidateMode.onUserInteraction;
        });
      }
    }

    void showSendEmailDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField = TextEditingController();
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("회원가입한 이메일을 입력해주세요.",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold
                      ),
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
                                  color: Color(COLOR_PRIMARY),
                                  width:2
                              ),
                            ),
                            hintText: "something@example.com",
                            labelText: "이메일",
                              labelStyle: TextStyle(
                                color: Colors.black87,
                              ),
                              hintStyle: TextStyle(
                                color: Colors.black38,
                              )
                          ),
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
                            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
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
                                  auth.FirebaseAuth.instance.sendPasswordResetEmail(email: _emailControllerField.text);
                                  final snackBar = SnackBar(
                                    content: Text("Check your email for password reset."),
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  print(e);
                                }
                              } else {
                                setState(() {
                                  _forgotvalidate = AutovalidateMode.onUserInteraction;
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

    //상단부 이미지
    final logo = Image.asset(
      "lib/image/Loading.gif",
      height: size.height / 4,
    );
    // final logo = Expanded(
    //   child: Padding(
    //     padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
    //     child: FittedBox(
    //       fit: BoxFit.contain,
    //       child: CircleAvatar(
    //         minRadius: 40,
    //         backgroundImage: AssetImage("lib/image/Loading.gif"),
    //       ), //CircleAvatar
    //     ), //FittedBox
    //   ), //Padding
    // ); //Expanded

    final emailField = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(COLOR_PRIMARY),
            width:2
          ),
        ),
        labelText: "이메일",
        hintText: "something@example.com",
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
      ), //InputDecoration
      textInputAction: TextInputAction.next,
      validator: validateEmail,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
          borderSide: BorderSide(
            color: Color(COLOR_PRIMARY),
            width: 2
          ),
        ),
        hintText: "password",
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
                  "비밀번호 찾기",
                  style: TextStyle(color:Colors.black, fontSize: 13),
                ),
                onPressed: () {
                  showSendEmailDialog(context);
                }),
            MaterialButton(
                child: Text(
                  "회원가입",
                  style: TextStyle(color:Colors.black, fontSize: 13),
                ),
                onPressed: () {
                  print("please implement register");
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
                  color:Colors.white,
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
