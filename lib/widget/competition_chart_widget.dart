import 'package:flutter/material.dart';
import 'ordinal_combo_bar_line_chart_widget.dart';

class CompetitionChartWidget extends StatefulWidget {
  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(height: size.height, width: size.width, child: OrdinalComboBarLineChartWidget.withSampleData()),
      ),
    );
  }
}
