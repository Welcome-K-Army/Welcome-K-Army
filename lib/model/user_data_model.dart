import 'package:flutter/material.dart';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:json_annotation/json_annotation.dart';
part 'user_data_model.g.dart';

@JsonSerializable()
class UserData {
  String uid;
  String nickName;
  final String email;
  int age;
  String gender;
  String creationDate;
  // String imageURL;

  UserData({
    this.uid,
    this.nickName,
    this.email,
    this.gender,
    this.age,
    this.creationDate,
    // this.imageURL,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataToJson(this);
}
