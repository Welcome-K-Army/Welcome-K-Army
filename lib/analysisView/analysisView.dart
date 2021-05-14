import "pacakge:flutter/material.dart";
import "package:flutter/src/widgets/basic.dart";

class AnalysisView extends StatefulWidget {
  AnalysisView createState() => new AnalysisStateView();
}

class AnalysisStateView extends State<AnalysisView> {
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
              height: 150,
              color: Colors.amberAccent,
            ),
            Text("항목별 분석"),
            Container(
              height: 150,
              color: Colors.blueAccent,
            ),
            Text("경쟁률"),
            Container(
              height: 150,
              color: Colors.redAccent,
            ),
          ]
        )
      )
    );
  }
}
