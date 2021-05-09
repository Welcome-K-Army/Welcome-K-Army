import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'BottomSheet/FilterData.dart';
import 'School.dart';

List<School> fillData() {
  List<School> lists = [];
  lists.add(new School(
      idx: 1,
      name: "육군사관학교",
      latlng: LatLng(37.623787, 127.098831),
      category: Categories.Army,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
      idx: 2,
      name: "해군사관학교",
      latlng: LatLng(35.127210, 128.662695),
      category: Categories.Navy,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
      idx: 3,
      name: "공군사관학교",
      latlng: LatLng(35.127210, 128.662695),
      category: Categories.AirForce,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  return lists;
}

class FilteredResultScreen extends StatelessWidget {
  final FilterData filterData;
  final List<School> schoolList = fillData();

  FilteredResultScreen(this.filterData);

  bool filter(School data){
    if(filterData.categories != null && filterData.categories != data.catagory)
      return false;
    if(filterData.classes != null && filterData.classes != data.classes)
      return false;
    if(filterData.types != null && filterData.types != data.type)
      return false;
    if(filterData.ages != null && filterData.ages != data.age)
      return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: schoolList.where((school) => filter(school)).toList().map((school) => Text(school.name)).toList(),
    ));
  }
}
