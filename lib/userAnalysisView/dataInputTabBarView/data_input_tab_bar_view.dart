import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'toggle_with_pie_and_radar_chart.dart';
import 'pie_chart_with_text.dart';
import 'toggle_with_combo_bar_line_chart.dart';

class DataInputTabBarView extends StatefulWidget {
  DataInputTabBarViewState createState() => new DataInputTabBarViewState();
}

class DataInputTabBarViewState extends State<DataInputTabBarView> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text("userDataInput"),
        ),
        body: TabBarView(
          children: <Widget> [
            Tab(text: "1차시험"),
            Tab(text: "2차시험"),
            Tab(text: "내신 및 수능"),
          ]
        )
    );
  }
}
