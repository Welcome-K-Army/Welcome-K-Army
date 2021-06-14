import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../filterScreen/School.dart';

import "../search/search.dart";

class FilteredMap extends StatefulWidget {
  final List<School> filteredData;
  //
  FilteredMap(this.filteredData);

  @override
  State<FilteredMap> createState() => FilteredMapState();
}

class FilteredMapState extends State<FilteredMap> {
  Completer<GoogleMapController> _controller = Completer();

  final _textcontroller =TextEditingController();

  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 14.4746,
  // );

  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(36.503364, 127.929206), zoom: 7);

  @override
  Widget build(BuildContext context) {
    final applicationBloc = Provider.of<Applicationbloc>(context);

    return Scaffold(
      body: ListView(padding:const EdgeInsets.all(8),children:[
        Padding (
          padding :const EdgeInsets.all(8),
          child:TextFiled(
            controller:_textcontroller,
            textCapitalization:TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Search Location', suffixIcon: Icon(Icons.search)),
            onChanged:(value) => applicationBloc.searchPlaces(value),//값확인하는 클래스 생성
            onTap()=>applicationBloc.clear_value(), //해당 객체 선택하면 detailview 보여주는 함수생성

          ),//TextFiled

        ),//Padding
        Stack(children:[
          Container(height:600,
            child:GoogleMap(
                mapType: MapType.normal,
                markers: _createMarkers(),
                initialCameraPosition: initialPosition,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),//GoogleMap
           ),//Container
        if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
          Container(
            height: 600,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.black.withOpacity(.6), backgroundBlendMode: BlendMode.darken),
          ),
        if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
          Container(
            height: 600,
            child: ListView.builder(
                itemCount: applicationBloc.searchResults.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(applicationBloc.searchResults[index].name, style: TextStyle(color: Colors.white)), //Text
                    onTap: () {
                      // applicationBloc.selected_place(applicationBloc.prelistview[index].number);
                    //applicationBloc.setSelectedLocation(applicationBloc.searchResults[index].placeId);
                    },
                  );
                }),
          ),

        ])


      ])
    );
  }

    GoogleMap(
      mapType: MapType.normal,
      markers: _createMarkers(),
      initialCameraPosition: initialPosition,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(initialPosition));
  // }

  Set<Marker> _createMarkers() {
    return widget.filteredData
        .map((school) => Marker(
            markerId: MarkerId(school.name),
            position: school.latlng,
            infoWindow: InfoWindow(title: school.name, snippet:school.address,)))
        .toSet();
  }
}
