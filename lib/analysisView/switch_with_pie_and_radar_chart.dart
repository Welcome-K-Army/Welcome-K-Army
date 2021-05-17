import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './chart/radar_chart.dart';
import './chart/donut_auto_label_chart.dart';

import 'custom_toggle_button.dart';

class SwitchWithPieAndRadarChart extends StatefulWidget {
  String title;
  SwitchWithPieAndRadarChart({this.title});

  _SwitchWithPieAndRadarChartState createState() => _SwitchWithPieAndRadarChartState(title: title);
}

class _SwitchWithPieAndRadarChartState extends State<SwitchWithPieAndRadarChart> {
  String title;

  _SwitchWithPieAndRadarChartState({this.title});

  bool status = false;

  Function chartSetState = () {
    status = !status;
  };

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
        CustomToggleButton(widgetSetStatus: chartSetState, firstButtonColor: Colors.red, secondButtonColor: Colors.grey[300], borderColor: Colors.black),
        ) 
      ]),
    );
  }
}
