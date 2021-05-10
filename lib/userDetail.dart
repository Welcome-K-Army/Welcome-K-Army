import 'package:flutter/material.dart';



class UserDetail extends ChangeNotifier {
  UserDetail({uId,nickName,email,age,gender});

  String uId;
  String nickName;
  String email;
  int age;
  String gender;


  update(){
    notifyListeners();
  }
  
}
