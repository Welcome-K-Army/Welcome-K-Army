import 'dart:async';
import 'package:flutter/material.dart';
import '../search_controller.dart';
import '../School.dart';
import '../data.dart';
import '../../detailView/detail_main.dart';


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
                    final arguments=Arguments(dataSet[i].name,dataSet[i].address,dataSet[i].number,dataSet[i].web_address,dataSet[i].image,dataSet[i].pdfurl,dataSet[i].web_address_detail,dataSet[i].one,
                dataSet[i].two,dataSet[i].three,dataSet[i].four);
                  }
                } //for
                          

              });
            },
            onTap: () {
              setState(()async{
                final result= await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context)=>DetailView(arguments:arguments)),
                );  
                controller.clear();
                data_filtered=[];
              });
            }
          ), //TextFiled
        )); 
  }
}