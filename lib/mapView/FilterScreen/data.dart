import 'School.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
