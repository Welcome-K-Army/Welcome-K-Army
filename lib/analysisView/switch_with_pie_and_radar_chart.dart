import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import './chart/pie_chart.dart';
import './chart/radar_chart.dart';
import './chart/pie_charta.dart';

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
                Container(
                  height: 400,
                  width: 400,
                  child: 
                status
                    ? DonutAutoLabelChart.withSampleData()
                    : Container(
                        child: CustomPaint(
                          // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                          size: Size(300, 300), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                          painter: PieChart(
                              percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                              textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다.
                              textColor: Colors.blueGrey),
                        ),
                      ),
                )
              ],
            ),
          ),
        ),
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
          /*
        switchBorder: Border.all(
          color: Color(0xFF0C9869),
          width: 6.0,
        ),
          toggleBorder: Border.all(
            color: Color.fromRGBO(2, 107, 206, 1),
            width: 5.0,
          ),
          */
          activeColor: Color(0xFFEF9A9A),
          inactiveColor: Color(0xFF0C9869),
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              status = val;
            });
          },
        ),
      ]),
    );
  }
}
