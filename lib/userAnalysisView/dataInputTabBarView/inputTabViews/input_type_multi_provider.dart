import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() => status;

  void setStatus(value) {
    status = value;
    notifyListeners(); //must be inserted
  }
}

class InstitutionStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() => status;

  void setStatus(value) {
    status = value;
    notifyListeners(); //must be inserted
  }
}
