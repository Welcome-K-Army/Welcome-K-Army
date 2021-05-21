import 'package:provider/provider.dart';

class TypeStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() => status;

  void toggle() {
    status = !status;
    notifyListeners(); //must be inserted
  }
}

class InstitutionStatus with ChangeNotifier {
  bool status = true;

  bool getStatus() => status;

  void toggle() {
    status = !status;
    notifyListeners(); //must be inserted
  }
}