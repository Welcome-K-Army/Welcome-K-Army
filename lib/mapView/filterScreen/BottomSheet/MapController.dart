import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController with ChangeNotifier{
  GoogleMapController controller;

  MapController({this.controller});

  void updateData(){
    notifyListeners();
  }

// Provider.of<Person>(context, listen: false)
}