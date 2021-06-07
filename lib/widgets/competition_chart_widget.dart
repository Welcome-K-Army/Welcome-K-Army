import 'package:flutter/material.dart';


class CompetitionChartWidget extends StatefulWidget {
  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Image.asset("lib/image/1.jpg"),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
            Divider(color: Color(0xFFD6D6D6), thickness: 1),
          ],
        ),
      ),
    );
  }
}
