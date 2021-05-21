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
  String imageURL;

  UserData({
    this.uid,
    this.nickName,
    this.email,
    this.gender,
    this.age,
    this.creationDate,
    this.imageURL,
  });

  void setUserData(UserData setuserData) {
    this.uid = setuserData.uid ;
    this.nickName = setuserData.nickName ;
    this.email = setuserData.email ;
    this.age = setuserData.age;
    this.gender = setuserData.gender;
    this.creationDate = setuserData.creationDate;
    this.imageURL=setuserData.imageURL;
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
      imageURL:json['imageURL'].toString(),
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
      'imageURL':imageURL,
    };
  }

}
