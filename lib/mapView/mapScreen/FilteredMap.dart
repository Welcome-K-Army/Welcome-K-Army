import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../filterScreen/School.dart';

class FilteredMap extends StatefulWidget {
  final List<School> filteredData;
  //
  FilteredMap(this.filteredData);

  @override
  State<FilteredMap> createState() => FilteredMapState();
}

class FilteredMapState extends State<FilteredMap> {
  Completer<GoogleMapController> _controller = Completer();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(36.503364, 127.929206), zoom: 7);

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      markers: _createMarkers(),
      initialCameraPosition: initialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
  // }

  Set<Marker> _createMarkers() {
    return widget.filteredData
        .map((school) => Marker(
            markerId: MarkerId(school.name),
            position: school.latlng,
            infoWindow: InfoWindow(title: school.name)))
        .toSet();
  }
}
