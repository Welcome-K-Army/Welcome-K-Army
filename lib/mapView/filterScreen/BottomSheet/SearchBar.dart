import 'dart:async';
import 'package:flutter/material.dart';
import '../search_controller.dart';
import '../School.dart';
import '../data.dart';


class SearhBar extends StatefulWidget {
  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {

  TextEditingController controller = TextEditingController();
  List<School> dataSet=fillData();
  List<School> data_filtered=[];
  String _searchResult;
  
  @override
  void initState(){
    super.initState();
    data_filtered=dataSet;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(3),
        child:Padding(
          padding: const EdgeInsets.all(4),
          child: TextField(
            controller:controller,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(hintText: 'Search Location', suffixIcon: Icon(Icons.search)),

            onChanged:(value){
              setState((){
                _searchResult=value;
                data_filtered=dataSet.where((data)=>data.name.contains(_searchResult)).toList();

              });
            }
          ), //TextFiled
        )); //Padding );
  }
}