import 'dart:async';
import 'package:flutter/material.dart';
import '../search_controller.dart';
import '../School.dart';
import '../data.dart';
import "../detailView/detail_main.dart";


class SearhBar extends StatefulWidget {
  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {

  TextEditingController controller = TextEditingController();
  List<School> dataSet=fillData();
  List<School> data_filtered=[];
  // String _searchResult;
  
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

            onChanged:(value)async{
              setState((){
                // _searchResult=value;
                for (int i = 0; i <= dataSet.length; i++) {
                  if (value == dataSet[i].name) {
                    data_filtered.add( dataSet[i]);
                  }
                } //for
                final arguments=Arguments(value.name,value.address,value.number,value.web_address,value.image,value.pdfurl,value.web_address_detail,value.one,
                value.two,value.three,value.four);
                final result=await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>DetailView(arguments:arguments)),
                );

              });
            },
            onTap: () async{
              setState((){
                
                controller.clear();
                data_filtered=[];
              });
            }
          ), //TextFiled
        )); 
  }
}