import 'package:flutter/material.dart';
import 'dart:core';

class UserData with ChangeNotifier {
  String uid;
  String nickName;
  String email;
  int age;
  String gender;
  String creationDate;

  UserData({
    this.uid:"",
    this.nickName:"",
    this.email:"",
    this.gender:"",
    this.age:0,
    this.creationDate:"",
  });

  void setUserData(UserData setuserData) {
    this.uid = setuserData.uid == null ? "" : setuserData.uid;
    this.nickName = setuserData.nickName == null ? "" : setuserData.nickName;
    this.email = setuserData.email == null ? "" : setuserData.email;
    this.age = setuserData.age == null ? 0 : setuserData.age;
    this.gender = setuserData.gender == null ? "" : setuserData.gender;
    this.creationDate = setuserData.creationDate == null ? "" : setuserData.creationDate;
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
}
