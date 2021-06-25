import 'package:flutter/material.dart';
import 'ordinal_combo_bar_line_chart_widget.dart';

class CompetitionChartWidget extends StatefulWidget {
  List<List<int>> competition_data;

  CompetitionChartWidget(this.competition_data, {Key key}) : super(key: key);

  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  @override
  Widget build(BuildContext context) {
    List<List<int>> competition_data_ = widget.competition_data;
    Size size = MediaQuery.of(context).size;
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(height: size.height, width: size.width, child:OrdinalComboBarLineChartWidget.withSampleData(widget.competition_data)),
      ),
    );
  }
}
