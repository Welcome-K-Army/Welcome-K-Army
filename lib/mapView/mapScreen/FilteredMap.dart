import 'dart:async';
import 'package:Army/mapView/filterScreen/BottomSheet/MapController.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../filterScreen/School.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import "../detailView/detail_main.dart";


class FilteredMap extends StatefulWidget {
  final List<School> filteredData;
  //
  FilteredMap(this.filteredData);

  @override
  State<FilteredMap> createState() => FilteredMapState();
}

class FilteredMapState extends State<FilteredMap> {
  Completer<GoogleMapController> _controller = Completer();

  void provideController()async{
    var controllerProvider = Provider.of<MapController>(context, listen: false);
    controllerProvider.controller = await _controller.future;
    controllerProvider.updateData();
  }

  bool _isMapLoaded = false;
  bool _isAnimationEnd = false;
  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(36.503364, 127.929206), zoom: 7);

  @override
  void initState() {
    provideController();
    _controller.future.whenComplete(() {

      if (this.mounted) {
        setState(() => _isMapLoaded = true);
      }
      Future.delayed(const Duration(milliseconds: 1500),
          () => setState(() => _isAnimationEnd = true)
      );
    });
    super.initState();
  }

  @override
  void dispose(){
    _isAnimationEnd=false;
    super.dispose();

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
            )))
      ],
    );
  }


  Future<void> cameraMove(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition targetPos = CameraPosition(target: pos, zoom: 12);
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPos));
  }


  Set<Marker> _createMarkers() {
    return widget.filteredData
        .map((school) => Marker(
              markerId: MarkerId(school.name),
              position: school.latlng,
              onTap: () => cameraMove(school.latlng),
              infoWindow: InfoWindow(
                title: school.name,
                snippet: school.address,
                onTap: () async {
                  final arguments = Arguments(
                      school.name,
                      school.address,
                      school.number,
                      school.web_address,
                      school.image,
                      school.pdfurl,
                      school.web_address_detail,
                      school.one,
                      school.two,
                      school.three,
                      school.four);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailView(arguments: arguments)),
                  );
                },
              ),
            ))
        .toSet(); //Marker)
  }
}
