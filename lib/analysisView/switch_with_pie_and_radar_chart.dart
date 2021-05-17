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
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18.0)
          ), 
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(child: Text("Donut".toUpperCase(), style: TextStyle(fontSize: 14)), style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(Colors.red), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)))), onPressed: (status) => { status = false }),
            SizedBox(width: 10),
            ElevatedButton(child: Text("Radar".toUpperCase(), style: TextStyle(fontSize: 14)), style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(Colors.red), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0), side: BorderSide(color: Colors.red)))), onPressed: (status) => { status = true })
          ])
        )
        /*
        FlutterSwitch(
          activeText: "Pie",
          inactiveText: "Radar",
          width: 150.0,
          height: 55.0,
          toggleSize: 75.0,
          value: status,
          borderRadius: 30.0,
          padding: 1.0,
          toggleColor: Color.fromRGBO(225, 225, 225, 1),
        switchBorder: Border.all(
          color: Color(0xFF0C9869),
          width: 6.0,
        ),
          toggleBorder: Border.all(
            color: Color.fromRGBO(2, 107, 206, 1),
            width: 5.0,
          ),
          activeColor: Color(0xFFEF9A9A),
          inactiveColor: Color(0xFF0C9869),
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),
        */
      ]),
    );
  }
}
