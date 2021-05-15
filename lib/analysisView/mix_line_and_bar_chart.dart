import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/bar_chart.dart';
import './chart/line_chart.dart';

class MixLineAndBarChart extends StatefulWidget {
  String title;
  Size size;
  MixLineAndBarChart({this.title, this.size});

  _MixLineAndBarChartState createState() => _MixLineAndBarChartState(title: title, size: size);
}

class _MixLineAndBarChartState extends State<MixLineAndBarChart> {
  String title;
  Size size;

  _MixLineAndBarChartState({this.title, this.size});

  bool status = false;
  Color _textColor = Colors.black;
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
    return Column(children: [
      Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
      Container(
        child: CustomPaint(
          size: Size(250, 250),
          painter: BarChart(data: points, labels: labels, color: Colors.pinkAccent),
          foregroundPainter: LineChart(points: points, pointSize: 5.0, pointColor: Colors.pinkAccent, lineColor: Colors.blue, lineWidth: 2.0),
        ),
      ),
    ]);
  }
}
