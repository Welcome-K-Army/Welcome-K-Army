import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/pie_chart.dart';
import './chart/line_chart.dart';
import './chart/bar_chart.dart';

class AnalysisView extends StatefulWidget {
  AnalysisViewState createState() => new AnalysisViewState();
}

class AnalysisViewState extends State<AnalysisView> {
  List<double> points = [50, 90, 1003, 500, 150, 120, 200, 80];

  List<String> labels = [
    "2012",
    "2013",
    "2014",
    "2015",
    "2016",
    "2017",
    "2018",
    "2019",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Text("전체 분석"),
            Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다.. 
                  size: Size(150, 150), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다. 
                  painter: PieChart(percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                      textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다. 
                      textColor: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
            Text("항목별 분석"),
            Row(
              children: [
Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다.. 
                  size: Size(150, 150), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다. 
                  painter: PieChart(percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                      textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다. 
                      textColor: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
                Text("hi"),
Container(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                child: CustomPaint( // CustomPaint를 그리고 이 안에 차트를 그려줍니다.. 
                  size: Size(150, 150), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다. 
                  painter: PieChart(percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                      textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다. 
                      textColor: Colors.blueGrey),
                ),
              ),
            ],
          ),
        ),
      ),
                Text("hi"),
              ]
            ),
            Text("경쟁률"),
            Container(
                child: CustomPaint(
                  size: Size(150, 150),
                  painter: LineChart(points: points, pointSize: 5.0, pointColor: Colors.pinkAccent, lineColor: Colors.pinkAccent, lineWidth: 2.0),
                ),
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
              Container(
                child: CustomPaint(
                    size: Size(250, 250),
                    foregroundPainter: BarChart(
                        data: points,
                        labels: labels,
                        color: Colors.pinkAccent)),
              ),
          ]
        )
      )
    );
  }
}
