import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'dart:io';

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

Gender _userGender;
int _userAge;

class _ProfileState extends State<ProfileScreen> {
  final User user;
  _ProfileState(this.user);

  @override
  void initState() {
    super.initState();
    _nicknameController = TextEditingController(text: user.nickName);
    _userGender = user.gender == "MAN" ? Gender.MAN : Gender.WOMEN;
    _userAge = user.age;
  }

  final ImagePicker _imagePicker = ImagePicker();
  GlobalKey<FormState> _key = new GlobalKey();

  AutovalidateMode _validate = AutovalidateMode.disabled;

  String userGender() {
    return _userGender == Gender.MAN ? "MAN" : "WOMEN";
  }

  List<int> ageList = List<int>.generate(60, (int index) => index + 15); //15~75

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final imageField = Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8, bottom: 8),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          _image != null
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
              : displayCircleImage(
                  user.profilePictureURL.isEmpty
                      ? "lib/image/Loading.gif"
                      : user.profilePictureURL,
                  125,
                  false),
          Positioned(
            left: 80,
            right: 0,
            child: FloatingActionButton(
                backgroundColor: Color(COLOR_PRIMARY),
                child: Icon(Icons.camera_alt),
                mini: true,
                onPressed: _onCameraClick),
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
            '닉네임',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextFormField(
          style: TextStyle(color: Colors.black),
          controller: _nicknameController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
          ),
          validator: validateName,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          onFieldSubmitted: (_) => FocusScope.of(context).nextFocus(),
        )
      ],
    );

    final emailField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            '이메일',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            user.email,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        )
      ],
    );

    final genderField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            '성별',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Padding(
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
                    "여성",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    final ageField = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            '나이',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.center,
          child: DropdownButton(
            isExpanded: true,
            iconSize: 24,
            elevation: 16,
            hint: Text(
              "$_userAge 살",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black,
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
                      age.toString() + " 살",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        )),
        backgroundColor: Color(COLOR_PRIMARY),
        title: Text(
          '사용자 정보',
        ),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(36, 20, 36, 20),
        child: Form(
            key: _key,
            autovalidateMode: _validate,
            child: Column(
              children: [
                imageField,
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  nickNameField,
                  emailField,
                  genderField,
                  ageField,
                  SizedBox(
                    height: 40,
                  ),
                  Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(25.0),
                    color: Color(COLOR_PRIMARY),
                    child: MaterialButton(
                        minWidth: size.width / 1.2,
                        padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        child: Text(
                          "저장",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () async {
                          _saveProfile();
                          Navigator.pop(context);
                        }),
                  )
                ])
              ],
            ) //ListView

            ), //Form
      ), //Container
    ); //Scafolld
  }

  _saveProfile() async {
    if (_key.currentState.validate()) {
      showProgress(context, 'Saving Profile data, Please wait...', false);
      var profilePicUrl = '';
      try {
        if (_image != null) {
          updateProgress('Uploading image, Please wait...');
          profilePicUrl = await FireStoreUtils()
              .uploadUserImageToFireStorage(_image, user.userID);
          user.profilePictureURL = profilePicUrl;
        }
        user.nickName = _nicknameController.text;
        user.age = _userAge;
        user.gender = userGender();

        await FireStoreUtils.updateCurrentUser(user);
        hideProgress();
        MyAppState.currentUser = user;
      } catch (e) {
        print('_SignUpState._sendToServer $e');
        hideProgress();
      }
    } else {
      setState(() {
        _validate = AutovalidateMode.onUserInteraction;
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
          child: Text("갤러리에서 고르기",
              style: TextStyle(fontSize: 17.0, color: Color(COLOR_PRIMARY))),
          isDefaultAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.gallery);
            if (image != null)
              setState(() {
                _image = File(image.path);
              });
          },
        ),
        CupertinoActionSheetAction(
          child: Text("카메라로 찍기",
              style: TextStyle(fontSize: 17, color: Color(COLOR_PRIMARY))),
          isDestructiveAction: false,
          onPressed: () async {
            Navigator.pop(context);
            PickedFile image =
                await _imagePicker.getImage(source: ImageSource.camera);
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
}
