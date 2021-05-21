import "package:intl/intl.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TypeStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() {
    print("get"+DateTime.now());
    print(status);
    return status;
  }

  void setStatus(value) {
    status = value;
    notifyListeners(); //must be inserted
  }
}

class InstitutionStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() {
        if (status == null) {
      print("null");
      return true;
    }
    print("get"+DateTime.now().toString());
    print(status);
    return status;
  }

  void setStatus(bool value) {
    if (status == null) {
      print("null");
    }
    print("set"+DateTime.now().toString());
    print(status);
    status = value;
    notifyListeners(); //must be inserted
  }
}
