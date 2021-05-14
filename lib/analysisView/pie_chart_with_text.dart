import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './chart/pie_chart.dart';

class PieChartWithText extends StatefulWidget {
  String title;
  Size size;
  PieChartWithText({this.title, this.size});
  
  _PieChartWithTextState createState() => _PieChartWithTextState();
}

class _PieChartWithTextState extends State<PieChartWithText> {
  final String title;
  final Size size;

  _PieChartWithTextState({this.title, this.size});

  bool status = false;
  Color _textColor = Colors.black;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      Row(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                Container(
                  child: CustomPaint(
                    // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                    size: Size(size.width / 4, size.width / 4), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                    painter: PieChart(
                        percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
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
                  child: CustomPaint(
                    // CustomPaint를 그리고 이 안에 차트를 그려줍니다..
                    size: Size(size.width / 4, size.width / 4), // CustomPaint의 크기는 가로 세로 150, 150으로 합니다.
                    painter: PieChart(
                        percentage: 50, // 파이 차트가 얼마나 칠해져 있는지 정하는 변수입니다.
                        textScaleFactor: 1.0, // 파이 차트에 들어갈 텍스트 크기를 정합니다.
                        textColor: Colors.blueGrey),
                  ),
                ),
              ],
            ),
          ),
        ),
        Text("hi"),
      ]),
    ]);
  }
}
