import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import './chart/radar_chart.dart';
import './chart/donut_auto_label_chart.dart';

import 'custom_toggle_button.dart';

class PieAndRadarChartState extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void toggle() {
    this._state = !this._state;
    notifyListeners(); //must be inserted
  }
}

class ToggleWithPieAndRadarChart extends StatefulWidget {
  String title;
  ToggleWithPieAndRadarChart({this.title});

  _ToggleWithPieAndRadarChartState createState() => _ToggleWithPieAndRadarChartState(title: title);
}

class _ToggleWithPieAndRadarChartState extends State<ToggleWithPieAndRadarChart> {
  String title;

  _ToggleWithPieAndRadarChartState({this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChangeNotifierProvider(
      create: (context) => PieAndRadarChartState(),
      child: Consumer<PieAndRadarChartState>(
        builder: (context, PieAndRadarChartState, child) => Column(children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(height: 200, width: 200, child: PieAndRadarChartState.state ? CustomRadarChart() : DonutAutoLabelChart.withSampleData())
                ],
              ),
            ),
          ),
          CustomToggleButton(firstButtonColor: Colors.red, secondButtonColor: Colors.grey[300], borderColor: Colors.black),
        ]),
      ),
    ));
  }
}
