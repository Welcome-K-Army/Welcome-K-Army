import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import './chart/radar_chart.dart';
import './chart/donut_auto_label_chart.dart';

import 'custom_toggle_button.dart';

class ChartState extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void toggle() {
    this._state = !this._state;
    notifyListeners(); //must be inserted
  }
}

class SwitchWithPieAndRadarChart extends StatefulWidget {
  String title;
  SwitchWithPieAndRadarChart({this.title});

  _SwitchWithPieAndRadarChartState createState() => _SwitchWithPieAndRadarChartState(title: title);
}

class _SwitchWithPieAndRadarChartState extends State<SwitchWithPieAndRadarChart> {
  String title;

  _SwitchWithPieAndRadarChartState({this.title});

  @override
  Widget build(BuildContext context) {
    ChartState chartState;

    return Center(
        child: ChangeNotifierProvider.value(
      value: chartState,
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
                Container(height: 200, width: 200, child: chartState.state ? CustomRadarChart() : DonutAutoLabelChart.withSampleData())
              ],
            ),
          ),
        ),
        CustomToggleButton(firstButtonColor: Colors.red, secondButtonColor: Colors.grey[300], borderColor: Colors.black),
      ]),
    ));
  }
}
