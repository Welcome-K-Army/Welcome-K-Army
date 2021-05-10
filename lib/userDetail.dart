import 'package:flutter/material.dart';



class UserDetail extends ChangeNotifier {
  
  String _uId;
  String _nickName;
  String _email;
  int _age;
  String _gender;

  String get uId => _uId;
  String get nickName => _nickName;
  String get email => _email;
  int get age => _age;
  String get gender => _gender;

  void set uId(userUid) {
    _uId = userUid;
    notifyListeners();
  }

  void set nickName(userNickname) {
    _nickName = userNickname;
    notifyListeners();
  }

  void set email(userEmail) {
    _email = userEmail;
    notifyListeners();
  }

  void set age(userAge) {
    _age = userAge;
    notifyListeners();
  }

  void set gender(userGender) {
    _gender = userGender;
    notifyListeners();
  }
  
}
