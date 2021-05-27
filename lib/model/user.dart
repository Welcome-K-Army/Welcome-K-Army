import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String nickName;
  int age;
  String gender;

  String email;
  // String firstName;
  // String lastName;

  // String phoneNumber;

  bool active;

  Timestamp lastOnlineTimestamp;

  String userID;
  String profilePictureURL;

  bool selected;

  String appIdentifier;

  User(
      {this.nickName = '',
      this.gender = '',
      this.age = 0,
      this.email = '',
      // this.firstName = '',
      // this.phoneNumber = '',
      // this.lastName = '',
      this.active = false,
      this.selected = false,
      lastOnlineTimestamp,
      this.userID = '',
      this.profilePictureURL = ''})
      : this.lastOnlineTimestamp = lastOnlineTimestamp ?? Timestamp.now(),
        this.appIdentifier = 'Flutter Login Screen ${Platform.operatingSystem}';

  // String fullName() {
  //   return '$firstName $lastName';
  // }

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return new User(
        nickName: parsedJson['nickName'] ?? '',
        age: parsedJson['age'] as int ?? 0,
        gender: parsedJson['gender'] ?? '',
        email: parsedJson['email'] ?? '',
        // firstName: parsedJson['firstName'] ?? '',
        // lastName: parsedJson['lastName'] ?? '',
        active: parsedJson['active'] ?? false,
        lastOnlineTimestamp: parsedJson['lastOnlineTimestamp'],
        // phoneNumber: parsedJson['phoneNumber'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'nickName': this.nickName,
      'age': this.age,
      'gender': this.gender,
      'email': this.email,
      // 'firstName': this.firstName,
      // 'lastName': this.lastName,
      // 'phoneNumber': this.phoneNumber,
      'id': this.userID,
      'active': this.active,
      'lastOnlineTimestamp': this.lastOnlineTimestamp,
      'profilePictureURL': this.profilePictureURL,
      'appIdentifier': this.appIdentifier
    };
  }
}
