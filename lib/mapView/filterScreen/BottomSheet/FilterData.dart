import 'package:flutter/cupertino.dart';
import '../School.dart';

class FilterData with ChangeNotifier{
  Categories categories;
  Classes classes;
  Types types;
  Ages ages;

  FilterData({this.categories, this.classes, this.types, this.ages});

  void updateData(){
    notifyListeners();
  }

  // Provider.of<Person>(context, listen: false)
}