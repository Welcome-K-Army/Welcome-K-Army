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
      latlng: LatLng(36.579458, 127.524334),
      category: Categories.AirForce,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
    idx: 4,
    name: "육군 3사관학교",
    latlng: LatLng(35.986904, 128.988485),
    category: Categories.Army,
    type: Types.Cadets,
    age: Ages.A_19_25,
    classes: Classes.Officer));
  lists.add(new School(
      idx: 5,
      name: "국군간호사관학교",
      latlng: LatLng(36.398094, 127.349693),
      category: Categories.All,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
    idx: 6,
    name: "육군학생군사학교",
    latlng: LatLng(36.821519, 127.805987),
    category: Categories.Army,
    type: Types.CadetCandidate,
    age: Ages.A_20_27,
    classes: Classes.Officer));

  return lists;
}
