import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';

import './chart/oridinal_combo_bar_line_chart.dart';

import 'custom_toggle_button.dart';

class ComboBarChartState extends ChangeNotifier {
  bool _state = false;

  bool get state => _state;

  void toggle() {
    this._state = !this._state;
    notifyListeners(); //must be inserted
  }
}

class ToggleWithComboBarChart extends StatefulWidget {
  String title;
  
  ToggleWithComboBarChart({this.title});

  _ToggleWithComboBarChartState createState() => _ToggleWithComboBarChartState(title: title);
}

class _ToggleWithComboBarChartState extends State<ToggleWithComboBarChart> {
  String title;
  OridinalComboBarLineChart allChart = OrdinalComboBarLineChart.withSampleData();
  OridinalComboBarLineChart typeChart = OrdinalComboBarLineChart.withSampleData();

  _ToggleWithComboBarChartState({this.title});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: ChangeNotifierProvider(
      create: (context) => ComboBarChartState(),
      child: Consumer<ComboBarChartState>(
        builder: (context, ComboBarChartState, child) => Column(children: [
          Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(height: 200, width: 200, child: ComboBarChartState.state ? allChart : typeChart)
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
