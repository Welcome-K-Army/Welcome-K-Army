import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../filterScreen/School.dart';
import 'package:provider/provider.dart';

import "../search/search.dart";
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

  bool _isMapLoaded = false;
  bool _isAnimationEnd = false;
  static final CameraPosition initialPosition =
      CameraPosition(target: LatLng(36.503364, 127.929206), zoom: 7);

  @override
  void initState() {
    _controller.future.whenComplete(() {
      if(this.mounted){
        setState(() => _isMapLoaded = true);
      }
      Future.delayed(const Duration(milliseconds: 1500),
          () => setState(() => _isAnimationEnd = true));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final applicationBloc = Provider.of<Applicationbloc>(context);
//     return Scaffold(
//       body: ListView(padding: const EdgeInsets.all(8), children: [
//         Padding(
//           padding: const EdgeInsets.all(8),
//           child: TextField(
//             textCapitalization: TextCapitalization.words,
//             decoration: InputDecoration(hintText: 'Search Location', suffixIcon: Icon(Icons.search)),

//             onChanged: (value) => applicationBloc.searchPlaces(value), //값확인하는 클래스 생성
//             onTap: () => applicationBloc.clear_value(),
//           ), //TextFiled
//         ), //Padding
//         Stack(children: [
//           Container(
//             height: 600,
//             child: GoogleMap(
//               mapType: MapType.normal,
//               markers: _createMarkers(),
//               initialCameraPosition: initialPosition,
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//               },
//             ), //GoogleMap
//           ), //Container
//           if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
//             Container(
//               height: 600,
//               width: double.infinity,
//               decoration: BoxDecoration(color: Colors.black.withOpacity(.6), backgroundBlendMode: BlendMode.darken),
//             ),
//           if (applicationBloc.searchResults != null && applicationBloc.searchResults.length != 0)
//             Container(
//               height: 600,
//               child: ListView.builder(
//                   itemCount: applicationBloc.searchResults.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(applicationBloc.searchResults[index].name, style: TextStyle(color: Colors.white)), //Text
//                       onTap: () {
//                         // applicationBloc.selected_place(applicationBloc.prelistview[index].number);
//                         //applicationBloc.setSelectedLocation(applicationBloc.searchResults[index].placeId);
//                       },
//                     );
//                   }),
//             ),
//         ]),
//       ]),
//     ); //Scaffold

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

  Future<void> _cameraMove(LatLng pos) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition targetPos = CameraPosition(target: pos, zoom: 12);
    controller.animateCamera(CameraUpdate.newCameraPosition(targetPos));
  }

  Set<Marker> _createMarkers() {
    return widget.filteredData
        .map((school) => Marker(
            markerId: MarkerId(school.name),
            position: school.latlng,
            onTap: ()=>_cameraMove(school.latlng),
            infoWindow: InfoWindow(
                title: school.name,
                snippet: school.address,
                onTap: () async {
                  final arguments = Arguments(school.name, school.address,
                      school.number, school.web_address, school.image);
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailView(arguments: arguments)),
                  );
                })))
        .toSet(); //Marker)
  }
}
