import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String nickName;
  int age;
  String gender;

  String email;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;
  String profilePictureURL;

  bool selected;

  String appIdentifier;

  User({this.nickName = '', this.gender = '', this.age = 0, this.email = '', this.active = false, this.selected = false, lastOnlineTimestamp, this.userID = '', this.profilePictureURL = ''})
      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(nickName: parsedJson['nickName'] ?? '', age: parsedJson['age'] as int ?? 0, gender: parsedJson['gender'] ?? '', email: parsedJson['email'] ?? '', active: parsedJson['active'] ?? false, lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'], userID: parsedJson['id'] ?? parsedJson['userID'] ?? '', profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'nickName': this.nickName,
      'age': this.age,
      'gender': this.gender,
      'email': this.email,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier
    };
  }
}
