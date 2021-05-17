import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './chart/radar_chart.dart';
import './chart/donut_auto_label_chart.dart';

class SwitchWithPieAndRadarChart extends StatefulWidget {
  String title;
  SwitchWithPieAndRadarChart({this.title});

  _SwitchWithPieAndRadarChartState createState() => _SwitchWithPieAndRadarChartState(title: title);
}

class _SwitchWithPieAndRadarChartState extends State<SwitchWithPieAndRadarChart> {
  String title;

  _SwitchWithPieAndRadarChartState({this.title});

  bool status = false;
  Color _textColor = Colors.black;
  Color _firstButtonColor = Colors.red;
  Color _secondButtonColor = Colors.grey[300];
  Color _trueButtonColor = Colors.red;
  Color _falseButtonColor = Colors.grey[300];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(height: 200, width: 200, child: status ? CustomRadarChart() : DonutAutoLabelChart.withSampleData())
              ],
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(4),
          width : 170,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(22.0)
          ), 
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              child: Text(
                "Donut".toUpperCase(), 
                style: TextStyle(fontSize: 14)
              ), 
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                backgroundColor: MaterialStateProperty.all<Color>(_firstButtonColor), 
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0), 
                    side: BorderSide(color: _firstButtonColor),
                  )
                )
              ), 
              onPressed: () {
                setState(() { 
                 status = false;
                 _firstButtonColor = _trueButtonColor;
                 _secondButtonColor = _falseButtonColor;
                });
            },),
            SizedBox(width: 15),
            ElevatedButton(
              child: Text(
                "Radar".toUpperCase(), 
                style: TextStyle(fontSize: 14)
              ), 
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                backgroundColor: MaterialStateProperty.all<Color>(_secondButtonColor), 
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0), 
                    side: BorderSide(color: _secondButtonColor)
                  )
                )
              ), 
              onPressed: () {
                setState(() { 
                  status = true;
                  _firstButtonColor = _falseButtonColor;
                  _secondButtonColor = _trueButtonColor;
                });
              },),
          ])
        )
      ]),
    );
  }
}
