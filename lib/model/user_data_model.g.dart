part of 'user_data_model.dart';

UserData _$UserDataFromJson(Map<String, dynamic> json) {
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

Map<String, dynamic> _$UserDataToJson(UserData instance) => <String, dynamic>{
      'uid': instance.uid,
      'nickName': instance.nickName,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'createdAt': instance.creationDate,
      // 'imageURL':instance.imageURL,
    };
