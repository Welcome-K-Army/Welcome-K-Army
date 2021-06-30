import 'package:flutter/material.dart';
import 'ordinal_combo_bar_line_chart_widget.dart';
import 'package:Army/storage/storage.dart';

// ignore: must_be_immutable
class CompetitionChartWidget extends StatefulWidget {
  List<String> school_data;

  CompetitionChartWidget(this.school_data, {Key key}) : super(key: key);

  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  List<List<dynamic>> data = [];
  bool isExist = false;

  loadAsset() async {
    final myData = await StorageUtils().loadCsv("20200930_각군학교경쟁률.csv");
    data = myData;
    setState(() {});
    return data;
  }

  checkExist(name) {
    for (int i = 1; i < data.length; i++) {
      if (data[i][2] == name) {
        isExist = true;
        return;
      }
    }
  }

  filter_competiton(current_name) {
    List<List<dynamic>> filter_data = [];
    print(data.length);
    if (data.length == 0) return filter_data;

    for (int i = 1; i < data.length; i++) {
      if (data[i][2] == current_name) {
        filter_data.add([
          data[i][1].toString(), //year
          data[i][4].toString(), //man
          data[i][5].toString(),
        ]);
      }
    }
    return filter_data;
  }

  @override
  void initState() {
    loadAsset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final school_name = widget.school_data[0];
    //Size size = MediaQuery.of(context).size;
    checkExist(school_name);

    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
        padding: EdgeInsets.all(16.0), child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Padding(
                padding: EdgeInsets.all(16.0),
                child: data.length == 0
                    ? Center(child: CircularProgressIndicator())
                    : !isExist
                        ? Container()
                        : buildChart()))));
  }

  Widget buildChart() {
    final school_name = widget.school_data[0];
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("$school_name 입시 경쟁률 (2016 ~ 2019)"),
      Container(height: 10),
      Align(
          alignment: Alignment.centerRight,
          child: Column(children: [
            Wrap(
              direction: Axis.horizontal,
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(color: Colors.red, width: 10, height: 10)),
                Text("여자"),
              ],
            ),
            Wrap(direction: Axis.horizontal, children: [
              Padding(
                  padding: EdgeInsets.all(5),
                  child: Container(color: Colors.green, width: 10, height: 10)),
              Text("남자"),
            ])
          ])),
      Container(height: 10),
      Container(
          height: 444,
          child: OrdinalComboBarLineChartWidget.withSampleData(
              filter_competiton(school_name)))
    ]);
  }
}
//
