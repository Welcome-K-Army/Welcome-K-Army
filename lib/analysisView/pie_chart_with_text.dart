import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/donut_auto_label_chart.dart';

class PieChartWithText extends StatefulWidget {
  String title;
  Size size;
  PieChartWithText({this.title, this.size});

  _PieChartWithTextState createState() => _PieChartWithTextState(title: title, size: size);
}

class _PieChartWithTextState extends State<PieChartWithText> {
  String title;
  Size size;

  _PieChartWithTextState({this.title, this.size});

  bool status = false;
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
          height: size.width / 3,
          width : size.width / 3,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: DonutAutoLabelChart.withSampleData()
          ),
        ),
        Container(
          height: size.width / 3,
          width: size.width / 6,
          child: Text("hi"),
        ),
        Container(
          height: size.width / 3,
          width : size.width / 3,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: DonutAutoLabelChart.withSampleData()
          ),
        ),
        Container(
          height: size.width / 3,
          width: size.width / 6,
          child: Text("hi"),
        ),
      ]),
    ]);
  }
}
