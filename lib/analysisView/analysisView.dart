import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

class AnalysisView extends StatefulWidget {
  AnalysisViewState createState() => new AnalysisViewState();
}

class AnalysisViewState extends State<AnalysisView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("Analysis"),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: [
              SwitchWithPieAndRadarChart(title: "전체 분석"),
              PieChartWithText(title: "항목별 분석", size: size),
              MixLineAndBarChart(title: "경쟁률"),
            ])));
  }
}
