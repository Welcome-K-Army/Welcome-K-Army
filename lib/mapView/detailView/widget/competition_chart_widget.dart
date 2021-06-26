import 'package:flutter/material.dart';
import 'ordinal_combo_bar_line_chart_widget.dart';
import 'package:Army/storage/storage.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'dart:core';

// ignore: must_be_immutable
class CompetitionChartWidget extends StatefulWidget {
  List<List<int>> competition_data;
  List<String> school_data;

  CompetitionChartWidget(this.competition_data,this.school_data ,{Key key}) : super(key: key);

  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  List<List<dynamic>> data = [];
  loadAsset() async {
      final myData = await StorageUtils().loadCsv("20200930_각군학교경쟁률.csv");
      data = myData;
      return data;
      setState(() {});
  }


  filter_competiton(current_name){
    List<List<dynamic>> data;
    List<List<int>> filter_data=[];

    data=loadAsset();
    for(int i=0;i<data.length;i++){
      if(data[2][i]==current_name){
        filter_data.add((data[1][i],data[4][i],data[5][i]).toList());
      }
    }
    return filter_data;
  }

  @override
  void initState() {
    loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final school_name=widget.school_data[0];
    
    // List<List<int>> competition_data = widget.competition_data;
    // List<String>school_data_=widget.school_data;
    Size size = MediaQuery.of(context).size;

    return Container(
      child: SingleChildScrollView(
        child:
        Column(children: [
          Table(
            columnWidths: {
              0: FixedColumnWidth(size.width * 0.1),
              1: FixedColumnWidth(size.width * 0.1),
              2: FixedColumnWidth(size.width * 0.2),
              3: FixedColumnWidth(size.width * 0.2),
              4: FixedColumnWidth(size.width * 0.2),
              5: FixedColumnWidth(size.width * 0.2),
            },
            border: TableBorder.all(width: 1.0),
            children: data.map((item) {
              return TableRow(
                  children: item.map((row) {
                return Container(
                  // color:
                  // row.toString().contains("NA") ? Colors.red : Colors.green,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      row.toString(),
                      style: TextStyle(fontSize: 10.0),
                    ),
                  ),
                );
              }).toList());
            }).toList(),
          ),
          Container(
              height: size.height,
              width: size.width,
              child: OrdinalComboBarLineChartWidget.withSampleData(
                  filter_competiton(school_name))),
        ]),
      ),
    );
  }
}
