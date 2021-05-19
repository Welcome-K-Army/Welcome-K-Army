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
    notifyListeners();
  }

  factory fromJson(Map<String, dynamic> json) {
    this.uid: json['uid'].toString();
    this.nickName: json['nickName'].toString();
    this.email: json['email'].toString();
    this.age: json['age'] as int;
    this.gender: json['gender'].toString();
    this.creationDate: json['createdAt'].toString();
    return this;
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
