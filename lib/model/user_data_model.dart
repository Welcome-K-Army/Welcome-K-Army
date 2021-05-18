import 'package:flutter/material.dart';

class UserData extends ChangeNotifier {
  final String uid;
  final String nickName;
  final String email;
  final int age;
  final String gender;
  final String creationDate;

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

  factory UserData.fromJson(Map<String, dynamic> json) {
    final userData = UserData(
      uid: json['uid'].toString(),
      nickName: json['nickName'].toString(),
      email: json['email'].toString(),
      age: json['age'] as int,
      gender: json['gender'].toString(),
      creationDate: json['createdAt'].toString(),
    );
    return userData;
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
