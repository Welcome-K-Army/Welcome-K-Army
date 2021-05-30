import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:Army/constants.dart';
import 'package:Army/main.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/home/homeScreen.dart';
import 'package:image_picker/image_picker.dart';

enum Gender { MAN, WOMEN }
File _image;

class SignUpScreen extends StatefulWidget {
  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  GlobalKey<FormState> _key = new GlobalKey();
  TextEditingController _nicknameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  AutovalidateMode _validate = AutovalidateMode.disabled;
  Gender _userGender = Gender.MAN;
  String userGender() {
    return _userGender == Gender.MAN ? "MAN" : "WOMEN";
  }

  int _userAge;
  List<int> ageList = List<int>.generate(60, (int index) => index + 15); //15~75
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // if (Platform.isAndroid) {
    //   retrieveLostData();
    // }

    _sendToServer() async {
      if (_key.currentState.validate()) {
        showProgress(context, 'Creating new account, Please wait...', false);
        var profilePicUrl = '';
        try {
          auth.UserCredential result = await auth.FirebaseAuth.instance.createUserWithEmailAndPassword(email: _emailController.text.trim(), password: _passwordController.text.trim());
          if (_image != null) {
            updateProgress('Uploading image, Please wait...');
            profilePicUrl = await FireStoreUtils().uploadUserImageToFireStorage(_image, result.user.uid);
          }
          User user = User(email: _emailController.text, nickName: _nicknameController.text, age: _userAge, gender: userGender(), userID: result.user.uid, active: true, profilePictureURL: profilePicUrl);
          await FireStoreUtils.firestore.collection(USERS).doc(result.user.uid).set(user.toJson());
          hideProgress();
          MyAppState.currentUser = user;
          pushAndRemoveUntil(context, HomeScreen(user: user), false);
        } on auth.FirebaseAuthException catch (error) {
          hideProgress();
          String message = 'Couldn\'t sign up';
          switch (error.code) {
            case 'email-already-in-use':
              message = 'Email address already in use';
              break;
            case 'invalid-email':
              message = 'validEmail';
              break;
            case 'operation-not-allowed':
              message = 'Email/password accounts are not enabled';
              break;
            case 'weak-password':
              message = 'password is too weak.';
              break;
            case 'too-many-requests':
              message = 'Too many requests, '
                  'Please try again later.';
              break;
          }
          showAlertDialog(context, 'Failed', message);
          print(error.toString());
        } catch (e) {
          print('_SignUpState._sendToServer $e');
          hideProgress();
          showAlertDialog(context, 'Failed', 'Couldn\'t sign up');
        }
      } else {
        setState(() {
          _validate = AutovalidateMode.onUserInteraction;
        });
      }
    }

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

    final nicknameField = TextFormField(
      controller: _nicknameController,
      style: TextStyle(
        color: Colors.white,
      ),
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
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
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: validateEmail,
      controller: _emailController,
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

    final genderField = Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            height: 20,
            width: 20,
            child: Radio(
              value: Gender.MAN,
              groupValue: _userGender,
              activeColor: Colors.white,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Male",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
            width: 20,
            child: Radio(
              value: Gender.WOMEN,
              groupValue: _userGender,
              activeColor: Colors.white,
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
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Female",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );

    final ageField = Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      alignment: Alignment.center,
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
      textInputAction: TextInputAction.next,
      onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
      validator: validatePassword,
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
      textInputAction: TextInputAction.done,
      onFieldSubmitted: (_) {
        _sendToServer();
      },
      validator: (val) => validateConfirmPassword(_passwordController.text, val),
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
          onPressed: () {
            _sendToServer();
          }),
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
                // Navigator.of(context).pushNamed(AppRoutes.authLogin);
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

    final formUI = Container(
      height: size.height * 1.4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          logo,
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey.shade400,
                  child: ClipOval(
                    child: SizedBox(
                      width: 170,
                      height: 170,
                      child: _image == null
                          ? Image.asset(
                              'lib/image/Loading.gif',
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                ),
                Positioned(
                  left: 80,
                  right: 0,
                  child: FloatingActionButton(backgroundColor: Color(COLOR_ACCENT), child: Icon(Icons.camera_alt), mini: true, onPressed: _onCameraClick),
                )
              ],
            ),
          ),
          fields,
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: bottom,
          ),
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Color(COLOR_PRIMARY),
      body: Form(
        key: _key,
        autovalidateMode: _validate,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
          child: formUI,
        ),
      ),
    );
  }

  Future<void> retrieveLostData() async {
    final LostData response = await _imagePicker.getLostData();
    if (response == null) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _image = File(response.file.path);
      });
    }
  }

  _onCameraClick() {
    final action = CupertinoActionSheet(
      message: Text(
        "Add profile picture",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("Choose from gallery"),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image = await _imagePicker.getImage(source: ImageSource.gallery);
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text("Take a picture"),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image = await _imagePicker.getImage(source: ImageSource.camera);
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        )
      ],
      cancelButton: CupertinoActionSheetAction(
        child: Text("Cancel"),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
    showCupertinoModalPopup(context: context, builder: (context) => action);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _image = null;
    super.dispose();
  }
}
