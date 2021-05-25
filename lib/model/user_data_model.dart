import 'dart:core';

class UserData {
  String uid;
  String nickName;
  String email;
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

  copy(UserData copydata) {
    this.uid = copydata.uid;
    this.nickName = copydata.nickName;
    this.email = copydata.email;
    this.gender = copydata.gender;
    this.age = copydata.age;
    this.creationDate = copydata.creationDate;
    // copydata.imageURL,
    return this;
  }

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      uid: json['uid'].toString(),
      nickName: json['nickName'].toString(),
      email: json['email'].toString(),
      age: json['age'] as int,
      gender: json['gender'].toString(),
      creationDate: json['createdAt'].toString(),
      // imageURL:json['imageURL'].toString(),
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
      // 'imageURL':imageURL,
    };
  }
}
