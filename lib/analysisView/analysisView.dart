import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/pie_chart.dart';
import './chart/line_chart.dart';
import './chart/bar_chart.dart';
import './chart/radar_chart.dart';

import 'switch_with_pie_and_radar_chart.dart';
import 'pie_chart_with_text.dart';

class AnalysisView extends StatefulWidget {
  AnalysisViewState createState() => new AnalysisViewState();
}

class AnalysisViewState extends State<AnalysisView> {
  List<double> points = [
    50,
    90,
    1003,
    500,
    150,
    120,
    200,
    80
  ];
  
  List<String> labels = [
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Analysis"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SwitchWithPieAndRadarChart(title: "전체 분석"),
              PieChartWithText(title: "항목별 분석", size: size),
              Text("경쟁률"),
              Container(
                child: CustomPaint(
                  size: Size(150, 150),
                  painter: LineChart(points: points, pointSize: 5.0, pointColor: Colors.pinkAccent, lineColor: Colors.pinkAccent, lineWidth: 2.0),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
              Container(
                child: CustomPaint(
                  size: Size(250, 250), 
                  foregroundPainter: BarChart(data: points, labels: labels, color: Colors.pinkAccent),
                  painter: LineChart(points: points, pointSize: 5.0, pointColor: Colors.pinkAccent, lineColor: Colors.pinkAccent, lineWidth: 2.0),
                  ),
              ),
            ])));
  }
}
