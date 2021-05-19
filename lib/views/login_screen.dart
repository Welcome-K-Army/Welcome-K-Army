import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../theme/routes.dart';
import '../model/user_data_model.dart';
import '../net/firebase.dart';

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController(); //email 컨트롤러
  TextEditingController _passwordController = TextEditingController(); //password 컨트롤러
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    void showAlertDialog(BuildContext context) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            TextEditingController _emailControllerField = TextEditingController();
            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
              backgroundColor: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                width: size.width / 1.1,
                height: size.height / 3.5,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Text("Insert Reset Email:"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: TextField(
                        controller: _emailControllerField,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.black,
                            ),
                          ),
                          hintText: "something@example.com",
                          labelText: "Email",
                          labelStyle: TextStyle(
                            color: Colors.black,
                          ),
                          hintStyle: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(25.0),
                        color: Color(0xff0c9869),
                        child: MaterialButton(
                          minWidth: size.width / 2,
                          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 25.0),
                          child: Text(
                            "Send Reset Email",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              FirebaseAuth.instance.sendPasswordResetEmail(email: _emailControllerField.text);
                              Navigator.of(context).pop();
                            } catch (e) {
                              print(e);
                              // TODO: Add snackbar reporting error
                            }
                          },
                        ),
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
          color: Colors.white,
        ),
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          labelText: "Email",
          hintText: "something@example.com",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          hintStyle: TextStyle(
            color: Colors.white,
          ),
        ), //InputDecoration
        validator: (String value) {
          if (value.isEmpty) {
            return "Please input correct Email!";
          } else if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?").hasMatch(value.toString())) {
            //이메일 정규 표현식
            return "Not correct Email format";
          }
          return null;
        }); //TextFormField 이메일

    final passwordField = Column(
      children: <Widget>[
        TextFormField(
            obscureText: true,
            controller: _passwordController,
            style: TextStyle(
              color: Colors.white,
            ),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
              ),
              hintText: "password",
              labelText: "Password",
              labelStyle: TextStyle(
                color: Colors.white,
              ),
              hintStyle: TextStyle(
                color: Colors.white,
              ),
            ),
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Password!";
              } else if (value.length < 8) {
                return "Please enter a password of at least 8 digits!";
              }
              return null;
            }),
        Padding(
          padding: EdgeInsets.all(2.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MaterialButton(
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context).textTheme.caption.copyWith(color: Colors.white),
                ),
                onPressed: () {
                  showAlertDialog(context);
                }),
          ],
        ),
      ],
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          emailField,
          passwordField,
        ],
      ),
    );

    final loginButton = Consumer<UserData>(
      builder: (context, userData, child) => Material(
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
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              try {
                await Firebase.initializeApp();
                UserCredential user = await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
                CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
                String uid = FirebaseFirestore.instance.currentUser.uid.toString();

                users.doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
                  if (documentSnapshot.exists) {
                    print(documentSnapshot.data().toString());
                    Map<String, dynamic> data = documentSnapshot.data();
                    userData.setUserData(UserData.fromJson(data));
                  } else {
                    print('no data');
                  }
                });
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('nickName', user.user.displayName);
                Navigator.of(context).pushNamed(AppRoutes.menu);
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
          },
        ),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Not a member?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authRegister);
              },
              child: Text(
                "Sign Up",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
              ),
            ),
          ],
        ),
      ],
    );

    return ChangeNotifierProvider(
      create: (context) => UserData(),
      child: Scaffold(
        backgroundColor: Color(0xff0c9869),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(36),
            child: Container(
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  logo,
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
      ),
    );
  }
}
