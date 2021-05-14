import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../net/firebase.dart';
import '../theme/routes.dart';

enum Gender { MAN, WOMEN }

class Register extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repasswordController = TextEditingController();
  Gender _userGender = Gender.MAN;
  String userGender() {
    return _userGender == Gender.MAN ? "MAN" : "WOMEN";
  }

  int _userAge;
  List<int> ageList = List<int>.generate(60, (int index) => index + 15); //15~75

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final logo = Image.asset(
      "lib/image/Loading.gif",
      height: size.height / 4,
    );

    final nicknameField = TextFormField(
      controller: _nicknameController,
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
        hintText: "K Amry",
        labelText: "Nickname",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

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
        hintText: "something@example.com",
        labelText: "Email",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final genderField = Row(children: <Widget>[
      SizedBox(
        height: 20,
        width: 20,
        child: Radio(
          value: Gender.MAN,
          groupValue: _userGender,
          onChanged: (value) {
            setState(() {
              _userGender = value;
            });
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            _userGender = Gender.MAN;
          });
        },
        child: Text("Male",
            style: TextStyle(
              color: Colors.white,
            )),
      ),
      Container(),
      Container(),
      SizedBox(
        height: 20,
        width: 20,
        child: Radio(
          value: Gender.WOMEN,
          groupValue: _userGender,
          onChanged: (value) {
            setState(() {
              _userGender = value;
            });
          },
        ),
      ),
      GestureDetector(
        onTap: () {
          setState(() {
            _userGender = Gender.WOMEN;
          });
        },
        child: Text(
          "Female",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ]);

    final ageField = Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
      // height: 50.0,
      // width: size.width * 0.73,
      child: DropdownButton(
        isExpanded: true,
        iconSize: 24,
        elevation: 16,
        hint: Text(
          "- years old",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        dropdownColor: Color(0xff0c9869),
        style: TextStyle(
          color: Colors.white,
        ),
        value: _userAge,
        onChanged: (val) => setState(() => _userAge = val),
        items: [
          for (var age in ageList)
            DropdownMenuItem(
              value: age,
              child: SizedBox(
                // width: size.width * 0.73,
                child: Text(
                  age.toString() + " years old",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );

    final passwordField = TextFormField(
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
    );

    final repasswordField = TextFormField(
      obscureText: true,
      controller: _repasswordController,
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
        labelText: "Re-enter Password",
        labelStyle: TextStyle(
          color: Colors.white,
        ),
        hintStyle: TextStyle(
          color: Colors.white,
        ),
      ),
    );

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          nicknameField,
          emailField,
          genderField,
          ageField,
          passwordField,
          repasswordField,
        ],
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
        onPressed: () async {
          try {
            await Firebase.initializeApp();
            UserCredential user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            );
            User updateUser = FirebaseAuth.instance.currentUser;
            updateUser.updateProfile(displayName: _nicknameController.text);
            userSetup(_nicknameController.text, _emailController.text, userGender(), _userAge);
            Navigator.of(context).pushNamed(AppRoutes.menu);
          } on FirebaseAuthException catch (e) {
            if (e.code == 'weak-password') {
              print('The password provided is too weak.');
            } else if (e.code == 'email-already-in-use') {
              print('The account already exists for that email.');
            }
          } catch (e) {
            print(e.toString());
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        registerButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "Already have an account?",
              style: Theme.of(context).textTheme.subtitle1.copyWith(
                    color: Colors.white,
                  ),
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.authLogin);
              },
              child: Text(
                "Login",
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

    return Scaffold(
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
    );
  }
}
