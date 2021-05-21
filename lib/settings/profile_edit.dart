import 'dart:io'; //카메라 접근하기 위해 필요한 라이블럷ㄹ
import 'package:image_picker/image_picker.dart'; //갤러리 접근
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../model/user_data_model.dart';
import 'package:provider/provider.dart';
import '../net/firebase.dart';
import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:core';
import 'package:flutter/src/widgets/editable_text.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File image;
  String downloadURL;
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  TextEditingController profileNameTextEditingController;
  TextEditingController emailTextEditingController;
  TextEditingController ageTextEditingController;
  TextEditingController genderTextEditingController;

  @override
  void initState() {

    super.initState();
    profileNameTextEditingController = new TextEditingController(text: '{loadUser.nickName}');
    emailTextEditingController = new TextEditingController(text: "{loadUser.email}");
    ageTextEditingController = new TextEditingController(text: "{loadUser.age}");
    genderTextEditingController = new TextEditingController(text: "{loadUser.gender}");

  }
  

  void takePhoto(ImageSource source) async {
    final _picker = ImagePicker();
    final _pickimage = await _picker.getImage(source: source);
    print(_pickimage.path + "picked File");

    setState(() {
      if (_pickimage != null) {
        image = File(_pickimage.path);
      }
    });


    // FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    // Reference storageReference = await _firebaseStorage.ref().child("profile_image/test.png");
    // final metadata = SettableMetadata(contentType: 'image/png', customMetadata: {
    //   'picked-file-path': _pickimage.path
    // });
    // UploadTask uploadTask;
    // // UploadTask storageUploadTask = await storageReference.putFile(await image,metadata);

    // if (kIsWeb) {
    //   print("web");
    //   uploadTask = storageReference.putData(await _pickimage.readAsBytes(), metadata);
    // } else {
    //   print("no web");
    //   uploadTask = storageReference.putFile(File(_pickimage.path), metadata);
    // }
    // setState(() async {
    //   downloadURL = await storageReference.getDownloadURL();
    //   print(downloadURL);
    // });
  }
  
  void uploadfile(PickedFile metaimage) async{
    metaimage=_pickimage;
    FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
    Reference storageReference = await _firebaseStorage.ref().child("profile_image/test.png");
    final metadata = SettableMetadata(contentType: 'image/png', customMetadata: {
      'picked-file-path': metaimage.path
    });
    UploadTask uploadTask;
    // UploadTask storageUploadTask = await storageReference.putFile(await image,metadata);

    if (kIsWeb) {
      print("web");
      uploadTask = storageReference.putData(await metaimage.readAsBytes(), metadata);
    } else {
      print("no web");
      uploadTask = storageReference.putFile(File(metaimage.path), metadata);
    }
    setState(() async {
      downloadURL = await storageReference.getDownloadURL();
      print(downloadURL);
    });
    
  }


  @override
  Widget build(BuildContext context) {
    UserData userData = Provider.of<UserData>(context);

    // userData.setUserData(loadUser);

    CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');

    String uid = FirebaseAuth.instance.currentUser.uid.toString();
    users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data();
        userData.setUserData(UserData.fromJson(data));
      } else {
        print('no data');
      }
    });

    // userData.setUserData(userLoad());

    final usernicknameForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            'Profile Name',
            style: TextStyle(color: Colors.black),
          ),
        ),
        Consumer<UserData>(
          builder: (context, userData, child) => TextField(
            style: TextStyle(color: Colors.black),
            controller: profileNameTextEditingController..text = "test",
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            ),
          ),
        )
      ],
    );

    final useremailForm = Column(
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
          controller: emailTextEditingController,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        ),
      ],
    );
    final usergenderForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            'Gender',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: genderTextEditingController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        )
      ],
    );

    final userageForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text(
            'Age',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.black),
          controller: ageTextEditingController,
          decoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
          ),
        )
      ],
    );

    String _profileImageURL = "";
//https://ichi.pro/ko/flutterleul-sayonghayeo-cloud-storagee-imiji-eoblodeu-20936960459186

    final bottomSheet = Container(
        height: 100,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              'Choose Profile photo',
              style: TextStyle(
                fontSize: 20,
              ),
            ), //Text
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                FlatButton.icon(
                  icon: Icon(
                    Icons.camera,
                    size: 50,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.camera);
                    Navigator.pop(context);

                  },
                  label: Text(
                    'Camera',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                FlatButton.icon(
                  icon: Icon(
                    Icons.photo_library,
                    size: 50,
                  ),
                  onPressed: () {
                    takePhoto(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  label: Text(
                    
                    'Gallery',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ], //children
            )
          ],
        ) //column

        ); //container
    //bottomSheet

    final imageProfile = Center(
      child: Stack(
        children: [
          Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                  border: Border.all(width: 4, color: Colors.green),
                  boxShadow: [
                    BoxShadow(spreadRadius: 2, blurRadius: 10, color: Colors.black.withOpacity(0.1)), //BoxShadow
                  ],
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      //DB에서 사진가져와야댐
                      fit: BoxFit.cover, //원본크기 유지
                      image: (image != null) ? NetworkImage(image.path) : NetworkImage("https://cdn.pixabay.com/photo/2015/11/26/00/14/woman-1063100_960_720.jpg")))), //Container
// (_image != null)?Image.file(_image,fit.BoxFit.fill):Image.network('https://cdn.pixabay.com/photo/2015/11/26/00/14/woman-1063100_960_720.jpg'),
          Positioned(
            //프로필 수정ui
            bottom: 0,
            right: 0,

            child: InkWell(
              onTap: () {
                showModalBottomSheet(context: context, builder: ((builder) => bottomSheet));
              },
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green,
                ),
                child: Icon(Icons.edit, size: 30, color: Colors.white),
              ),
            ),
          ), //Positioned
        ],
      ), //Stack
    ); //Center

    return Consumer<UserData>(
      builder: (context, userData, child) => Scaffold(
        key: _scaffoldGlobalKey,
        body: Container(
          padding: EdgeInsets.only(left: 15, top: 20, right: 15),
          child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  imageProfile,
                  SizedBox(
                    height: 30,
                  ),
                  usernicknameForm,
                  useremailForm,
                  usergenderForm,
                  userageForm,
                  SizedBox(
                    height: 40,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    OutlinedButton(
                      onPressed: () async {
                        Navigator.pop(context);
                        // UserData test;
                        // test.setUserData(test.userLoad());
                        // print(test);
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
                      onPressed: () {
                        uploadfile();
                        userUpdate(profileNameTextEditingController.text, emailTextEditingController.text, genderTextEditingController.text, int.parse(ageTextEditingController.text));
                      }, //바뀐 데이터 db로 보내는 함수 만들어야댐 updateUserData
                      //String nickName, String email, String gender, int age
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
      ), //Scafolld
    );
  } //
}
