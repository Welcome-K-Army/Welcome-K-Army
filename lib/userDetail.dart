import 'package:flutter/material.dart';


class UserDetail extends ChangeNotifier{
  String _uid;
  String _nickName;
  String _email;
  int _age;
  String _gender;

  get uid => _uid;
  get nickName => _nickName;
  get email => _email;
  get age => _age;
  get gender => _gender;
  
  
  //notifyListeners();
}