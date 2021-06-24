import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import "../filterScreen/School.dart";
import "../filterScreen/data.dart";
// for i in range(lists.length){
//   if value contains(lists[i].name){
//     prelist.add(value)
//   }

class Applicationbloc with ChangeNotifier {
  List<School> datalist = fillData(); 

  List<School> searchResults;


  searchPlaces(String searchTerm) async {   
    if((await check_value(searchTerm))!=null){
      searchResults.add(check_value(searchTerm));
      print(searchResults);
    }
    notifyListeners();
  }

  check_value(String value) async {
    for (int i = 0; i <= datalist.length; i++) {
      if (value == datalist[i].name) {
        return datalist[i];
      } else {
        return null;
      }
    } //for
  } //check_value

  selected_value() async {
    notifyListeners();
  }

  clear_value() {
    searchResults = null;
    notifyListeners();
  }
}
