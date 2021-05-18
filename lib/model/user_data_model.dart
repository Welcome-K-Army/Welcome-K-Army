import 'package:flutter/material.dart';
import 'dart:core';

class UserData extends ChangeNotifier {
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

  void update() {
    notifyListeners();
  }

  void setUserData({String uid, String nickName, String email, int age, String gender, String creationDate}) {
    this.uid = uid;
    this.nickName = nickName;
    this.email = email;
    this.age = age;
    this.gender = gender;
    this.creationDate = creationDate;
    this.update();
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
