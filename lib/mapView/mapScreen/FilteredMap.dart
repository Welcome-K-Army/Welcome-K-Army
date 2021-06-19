import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
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
  bool _isMapLoaded = false;
  bool _isAnimationEnd = false;
  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(36.503364, 127.929206), zoom: 7);

  @override
  void initState() {
    _controller.future.whenComplete(() {
      setState(()=>_isMapLoaded = true);
      Future.delayed(const Duration(milliseconds: 1500), () => setState(() => _isAnimationEnd = true));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
            mapType: MapType.normal,
            markers: _createMarkers(),
            initialCameraPosition: initialPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            }),
        Visibility(
            visible: !_isAnimationEnd,
            child: SizedBox.expand(
              child: AnimatedOpacity(
                opacity: !(_isMapLoaded) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 1500),
                child: Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                ),
              )
            )
        )
      ],
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
