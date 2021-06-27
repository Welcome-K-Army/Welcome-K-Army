import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../School.dart';
import '../data.dart';
import '../../detailView/detail_main.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:Army/mapView/mapScreen/FilteredMap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';



class SearhBar extends StatefulWidget {



  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {
  Completer<GoogleMapController> mapController = Completer();
  TextEditingController controller = TextEditingController();
  List<School> dataSet = fillData();
  School data_filtered = null;
  List<School> result_data = [];
  FToast fToast;

  // String _searchResult;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  Future<void> cameraMove(LatLng pos) async{
   final GoogleMapController mapCameraController=await mapController.future;
    CameraPosition targetPos = CameraPosition(target: pos, zoom: 12);
  mapCameraController.animateCamera(CameraUpdate.newCameraPosition(targetPos));
  }

  void showErrorToast() {
    fToast.showToast(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "해당 결과가 없습니다.",
            style: TextStyle(color: Colors.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }


  void submit() async {
    if (data_filtered == null) {
      showErrorToast();
      return;
    }
    await cameraMove(data_filtered.latlng);
    data_filtered = null;
  }






  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 20,
              onPressed: submit,
            ),
            Expanded(
              child:TextField(
                textCapitalization: TextCapitalization.words,
                controller: controller,
                decoration: InputDecoration(
                  hintText: '이름으로 검색',
                ),
                onSubmitted: (value) {
                  for (int i = 0; i < dataSet.length; i++) {
                    if (value == dataSet[i].name) {
                      data_filtered = dataSet[i];
                    }
                  }
                  submit();
                },
              ),
            )
          ],
        )
      ),
    );
  }
}
