import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import './chart/ordinal_combo_bar_line_chart.dart';

class ToggleWithComboBarLineChart extends StatefulWidget {
  String title;
  Color firstButtonColor;
  Color secondButtonColor;
  ToggleWithComboBarLineChart({this.title, this.firstButtonColor, this.secondButtonColor});

  _ToggleWithComboBarLineChartState createState() => _ToggleWithComboBarLineChartState(title: title, firstButtonColor: firstButtonColor, secondButtonColor: secondButtonColor);
}

class _ToggleWithComboBarLineChartState extends State<ToggleWithComboBarLineChart> {
  String title;
  Color firstButtonColor;
  Color secondButtonColor;
  Color trueButtonColor;
  Color falseButtonColor;
  bool chartState = true;

  OrdinalComboBarLineChart allChart = OrdinalComboBarLineChart.withSampleData();
  OrdinalComboBarLineChart typeChart = OrdinalComboBarLineChart.withSampleData();

  _ToggleWithComboBarLineChartState({this.title, this.firstButtonColor, this.secondButtonColor}) {
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
                Container(height: 200, width: 200, child: chartState ? allChart : typeChart)
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
