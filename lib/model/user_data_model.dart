import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserData {
  final String uid;
  final String nickName;
  final String email;
  final int age;
  final String gender;
  final String creationDate;

  

  const UserData ({
    this.uid,
    this.nickName,
    this.email,
    this.gender,
    this.age,
    this.creationDate,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      uid: json['UID'].toString(),
      nickName: json['NickName'].toString(),
      email:json['Email'].toString(),
      age: json['Age'] as int,
      gender:json['Gender'].toString(),
      creationDate: json['CreationDate'].toString(),
    );
  }
  
}
