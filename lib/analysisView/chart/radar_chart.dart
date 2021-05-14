import 'package:flutter/material.dart';
import 'package:flutter_radar_chart/flutter_radar_chart.dart';

class CustomRadarChart extends StatefulWidget {
  const CustomRadarChart({Key key}) : super(key: key);

  @override
  _CustomRadarChartState createState() => _CustomRadarChartState();
}

class _CustomRadarChartState extends State<CustomRadarChart> {
  bool darkMode = false;
  bool useSides = false;
  double numberOfFeatures = 6;

  @override
  Widget build(BuildContext context) {
    const ticks = [
      7,
      14,
      21,
      28,
      35
    ];
    var features = [
      "AA",
      "BB",
      "CC",
      "DD",
      "EE",
      "FF",
      "GG",
      "HH"
    ];
    var data = [
      [
        10,
        20,
        28,
        5,
        16,
        15,
        17,
        6
      ],
      [
        15,
        1,
        4,
        14,
        23,
        10,
        6,
        19
      ]
    ];

    features = features.sublist(0, numberOfFeatures.floor());
    data = data.map((graph) => graph.sublist(0, numberOfFeatures.floor())).toList();

    return Container(
      height: 300,
      width: 300,
      child: RadarChart(
        ticks: ticks,
        features: features,
        data: data,
        reverseAxis: true,
        useSides: useSides,
      ),
    );
  }
}
