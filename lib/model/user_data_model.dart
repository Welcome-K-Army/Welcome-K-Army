import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
class UserData with ChangeNotifier {
  String uid;
  String nickName;
  String email;
  int age;
  String gender;
  String creationDate;

  UserData({
    this.uid,
    this.nickName,
    this.email,
    this.gender,
    this.age,
    this.creationDate,
  });

  void setUserData(UserData setuserData) {
    this.uid = setuserData.uid ;
    this.nickName = setuserData.nickName ;
    this.email = setuserData.email ;
    this.age = setuserData.age;
    this.gender = setuserData.gender;
    this.creationDate = setuserData.creationDate;
    notifyListeners();
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'].toString(),
      nickName: json['nickName'].toString(),
      email: json['email'].toString(),
      age: json['age'] as int,
      gender: json['gender'].toString(),
      creationDate: json['createdAt'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nickName': nickName,
      'email': email,
      'age': age,
      'gender': gender,
      'createdAt': creationDate,
    };
  }

  Future<UserData> userLoad() async {
  CollectionReference users = FirebaseFirestore.instance.collection('UserDetail');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  UserData loadingUser;
  if (uid != null) {
    users.doc(uid).get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data();
        loadingUser=UserData.fromJson(data);
      } else {
        print('no data');
      }
    });
  } else {
    print("no uid");
  }
  return loadingUser;
}
}
