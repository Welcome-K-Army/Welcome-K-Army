import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import "../filterScreen/School.dart";
import "../filterScreen/data.dart";
// for i in range(lists.length){
//   if value contains(lists[i].name){
//     prelist.add(value)
//   }

class Applicationbloc with ChangeNotifier {
  List<School> datalist = fillData(); //하드코딩된 값을 리턴

  List<School> searchResults;

  searchPlaces(String searchTerm) async {
    searchResults.add(await check_value(searchTerm)); //해당 밸류 검색해서 확인하는 함수
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
    notifyListeners();
  } //check_value

  selected_value() async {
    notifyListeners();
  }

  clear_value() {
    searchResults = null;
    notifyListeners();
  }
}
