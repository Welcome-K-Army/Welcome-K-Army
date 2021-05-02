import 'package:flutter/foundation.dart';


class JoinOrLogin extends ChangeNotifier{
  bool _isJoin=false;

  bool get isJoin => _isJoin;

  void toggle(isJoin){
    _isJoin=!_isJoin;
    notifyListeners();
  }
}