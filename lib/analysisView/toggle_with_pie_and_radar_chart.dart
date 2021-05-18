import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import './chart/radar_chart.dart';
import './chart/donut_auto_label_chart.dart';

class ToggleWithPieAndRadarChart extends StatefulWidget {
  String title;
  Color firstButtonColor;
  Color secondButtonColor;
  ToggleWithPieAndRadarChart({this.title, this.firstButtonColor, this.secondButtonColor});

  _ToggleWithPieAndRadarChartState createState() => _ToggleWithPieAndRadarChartState(title: title, firstButtonColor: firstButtonColor, secondButtonColor: secondButtonColor);
}

class _ToggleWithPieAndRadarChartState extends State<ToggleWithPieAndRadarChart> {
  String title;
  Color firstButtonColor;
  Color secondButtonColor;
  Color trueButtonColor;
  Color falseButtonColor;
  bool chartState = true;

  _ToggleWithPieAndRadarChartState({this.title, this.firstButtonColor, this.secondButtonColor}) {
    this.trueButtonColor = this.firstButtonColor;
    this.falseButtonColor = this.secondButtonColor;
  }

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
                Container(height: 200, width: 200, child: chartState ? CustomRadarChart() : DonutAutoLabelChart.withSampleData())
              ],
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ElevatedButton(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(firstButtonColor),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22.0),
                  side: BorderSide(color: firstButtonColor),
                ))),
            onPressed: () {
              setState(() {
                chartState = !chartState;
                firstButtonColor = trueButtonColor;
                secondButtonColor = falseButtonColor;
              });
            },
          ),
          SizedBox(width: 15),
          ElevatedButton(
            style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(secondButtonColor), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0), side: BorderSide(color: secondButtonColor)))),
            onPressed: () {
              setState(() {
                chartState = !chartState;
                firstButtonColor = falseButtonColor;
                secondButtonColor = trueButtonColor;
              });
            },
          ),
        ])
      ]),
    );
  }
}
