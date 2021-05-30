import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:Army/constants.dart';
import 'package:Army/main.dart';

enum Gender { MAN, WOMEN }
File _image;

class ProfileScreen extends StatefulWidget {
  final User user;

  ProfileScreen({Key key, @required this.user}) : super(key: key);

  @override
  State createState() {
    return _ProfileState(user);
  }
}

TextEditingController _nicknameController = TextEditingController();
TextEditingController _emailController = TextEditingController();
Gender _userGender;
int _userAge;

class _ProfileState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: user.nickName);
    _emailController = TextEditingController(text: user.email);
    _userGender = user.gender == "MAN" ? Gender.MAN : Gender.WOMEN;
    _userAge = user.age;
  }

  final User user;
  _ProfileState(this.user);

  final ImagePicker _imagePicker = ImagePicker();
  GlobalKey<FormState> _key = new GlobalKey();

  AutovalidateMode _validate = AutovalidateMode.disabled;

  String userGender() {
    return _userGender == Gender.MAN ? "MAN" : "WOMEN";
  }

  List<int> ageList = List<int>.generate(60, (int index) => index + 15); //15~75
  
  @override
  Widget build(BuildContext context) {
    final imageField = Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8, bottom: 8),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _image == null
              ? CircleAvatar(
                  radius: 65,
                  backgroundColor: Colors.grey.shade400,
                  child: ClipOval(
                    child: SizedBox(
                      width: 120,
                      height: 120,
                      child: _image == null
                          ? Image.asset(
                              "lib/image/Loading.gif",
                              fit: BoxFit.cover,
                            )
                          : Image.file(
                              _image,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                )
              : displayCircleImage(user.profilePictureURL == "" ? "lib/image/Loading.gif" : user.profilePictureURL, 125, false),
          Positioned(
            left: 80,
            right: 0,
            child: FloatingActionButton(backgroundColor: Color(COLOR_ACCENT), child: Icon(Icons.camera_alt), mini: true, onPressed: _onCameraClick),
          )
        ],
      ),
    );
    final nickNameField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            'Profile Name',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: _nicknameController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        )
      ],
    );

    final emailField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            'Email',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextFormField(
          controller: _emailController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        ),
      ],
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
              activeColor: Colors.black,
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
              activeColor: Colors.black,
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
        hint: Text(
          "- years old",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        dropdownColor: Colors.white,
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Form(
        key: _key,
        autovalidateMode: _validate,
        child: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  imageField,
                  SizedBox(
                    height: 30,
                  ),
                  nickNameField,
                  emailField,
                  genderField,
                  ageField,
                  SizedBox(
                    height: 40,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text("Cancel",
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: 2,
                            color: Colors.black,
                          )), //Text
                      style: OutlinedButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ), //OutlineButton

                    ElevatedButton(
                      onPressed: () {},
                      child: Text("Save",
                          style: TextStyle(
                            fontSize: 17,
                            letterSpacing: 2,
                            color: Colors.white,
                          )),
                      style: ElevatedButton.styleFrom(primary: Colors.green, padding: EdgeInsets.symmetric(horizontal: 50), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                    ) //ElevatedButton
                  ]),
                ],
              ) //ListView
              ),
        ), //Container
      ), //Form
    ); //Scafolld
  }

  // _saveProfile() async {
  //   if (_key.currentState.validate()) {
  //     showProgress(context, 'Saving Profile data, Please wait...', false);
  //     var profilePicUrl = '';
  //     try {
  //       String uid = auth.FirebaseAuth.instance.currentUser.uid;
  //       if (_image != null) {
  //         updateProgress('Uploading image, Please wait...');
  //         profilePicUrl = await FireStoreUtils().uploadUserImageToFireStorage(_image, uid);
  //       }
  //       await FireStoreUtils.firestore.collection(USERS).doc(uid).set(user.toJson());
  //       hideProgress();
  //       MyAppState.currentUser = user;
  //
  //     } on auth.FirebaseAuthException catch (error) {
  //       hideProgress();
  //       String message = 'Couldn\'t sign up';
  //       switch (error.code) {
  //         case 'email-already-in-use':
  //           message = 'Email address already in use';
  //           break;
  //         case 'invalid-email':
  //           message = 'validEmail';
  //           break;
  //         case 'operation-not-allowed':
  //           message = 'Email/password accounts are not enabled';
  //           break;
  //         case 'weak-password':
  //           message = 'password is too weak.';
  //           break;
  //         case 'too-many-requests':
  //           message = 'Too many requests, '
  //               'Please try again later.';
  //           break;
  //       }
  //       showAlertDialog(context, 'Failed', message);
  //       print(error.toString());
  //     } catch (e) {
  //       print('_SignUpState._sendToServer $e');
  //       hideProgress();
  //       showAlertDialog(context, 'Failed', 'Couldn\'t sign up');
  //     }
  //   } else {
  //     setState(() {
  //       _validate = AutovalidateMode.onUserInteraction;
  //     });
  //   }
  // }

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
}
