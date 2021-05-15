import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/pie_chart.dart';
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
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: DonutAutoLabelChart.withSampleData()
          ),
        ),
        Text("hi"),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: DonutAutoLabelChart.withSampleData()
          ),
        ),
        Text("hi"),
      ]),
    ]);
  }
}
