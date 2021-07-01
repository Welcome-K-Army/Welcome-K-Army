import 'dart:io';

import 'package:Army/assets/custom_icons.dart';
import 'package:Army/provider/pdf_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:Army/constants.dart';
import 'package:Army/main.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/firebaseUtil.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/ui/home/homeScreen.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  List<int> ageList = List<int>.generate(25, (int index) => index + 15); //15~40
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final node = FocusScope.of(context);

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
          final pdfProvider=Provider.of<PdfProvider>(context);
          pdfProvider.loadUrlList();
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

    final nicknameField = TextFormField(
      controller: _nicknameController,
      style: TextStyle(
        color: Colors.black,
      ),
      validator: validateName,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      cursorColor: Colors.black,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(COLOR_PRIMARY),
            width: 2
          ),
        ),
        hintText: "35사단 멋쟁이",
        labelText: "닉네임",
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        hintStyle: TextStyle(
          color: Colors.black38,
        ),
      ),
    );

    final emailField = TextFormField(
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      validator: validateEmail,
      controller: _emailController,
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
              activeColor: Color(COLOR_PRIMARY),
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
                "남성",
                style: TextStyle(
                  color: Colors.black,
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
              activeColor: Color(COLOR_PRIMARY),
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
                "여성",
                style: TextStyle(
                  color: Colors.black,
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
        underline: Container(
          decoration: BoxDecoration(
              border: Border.all(width:0.5, color: Colors.black38)
          )
        ),
        hint: Text(
          "나이 설정",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,

          ),
        ),
        dropdownColor: Colors.white,
        style: TextStyle(
          color: Colors.black,
        ),
        value: _userAge,
        onChanged: (val) => setState(() => _userAge = val),
        items: [
          for (var age in ageList)
            DropdownMenuItem(
              value: age,
              child: SizedBox(
                child: Text(
                  age.toString() + "살",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black87,
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
        color: Colors.black,
      ),
      cursorColor: Colors.black,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => node.nextFocus(),
      validator: validatePassword,
      decoration: InputDecoration(
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(COLOR_PRIMARY),
            width:2
          ),
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
    );

    final repasswordField = TextFormField(
      obscureText: true,
      textInputAction: TextInputAction.done,
      validator: (val) => validateConfirmPassword(_passwordController.text, val),
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
        hintText: "비밀번호 재입력",
        labelText: "비밀번호 재입력",
        labelStyle: TextStyle(
          color: Colors.black87,
        ),
        hintStyle: TextStyle(
          color: Colors.black38,
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
          Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
          passwordField,
          repasswordField,
          Padding(padding: const EdgeInsets.symmetric(vertical: 15)),
          ageField,
          genderField,
        ],
      ),
    );
    final registerButton = Material(
      elevation: 15.0,
      borderRadius: BorderRadius.circular(25.0),
      color: Color(COLOR_PRIMARY),
      child: MaterialButton(
          minWidth: size.width / 1.2,
          padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
          child: Text(
            "회원가입",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white
            ),
          ),
          onPressed: () {
            _sendToServer();
          }),
    );


    final formUI = Container(
      height: size.height*1.3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8, bottom: 8),
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  child:CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: SizedBox(
                        width: 190,
                        height: 190,
                        child: _image == null
                            ? Icon(CustomIcons.go2star, color: Color(COLOR_PRIMARY), size: 190)
                            : Image.file(
                          _image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color:Color(COLOR_PRIMARY), width: 4)
                  ),
                ),
                Positioned(
                  left: 80,
                  right: 0,
                  child: FloatingActionButton(backgroundColor: Color(COLOR_PRIMARY), child: Icon(Icons.camera_alt), mini: true, onPressed: _onCameraClick),
                )
              ],
            ),
          ),
          fields,
          registerButton
        ],
      ),
    );
///////////////////////////////////////////////     return 문     ////////////////////////////////////////////////
    return Scaffold(
      backgroundColor: Colors.lightGreen[50],
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

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
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
        "사진을 추가해주세요.",
        style: TextStyle(fontSize: 15.0),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text("갤러리에서 고르기" ,style: TextStyle(fontSize: 17.0, color: Color(COLOR_PRIMARY))),
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
          child: Text("카메라로 찍기", style: TextStyle(fontSize: 17, color: Color(COLOR_PRIMARY))),
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
        child: Text("취소", style: TextStyle(color: Color(COLOR_PRIMARY))),
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
