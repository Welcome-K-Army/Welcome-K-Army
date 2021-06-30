import 'package:flutter/material.dart';
import 'ordinal_combo_bar_line_chart_widget.dart';
import 'package:Army/storage/storage.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';

// ignore: must_be_immutable
class CompetitionChartWidget extends StatefulWidget {

  List<String> school_data;

  CompetitionChartWidget( this.school_data, {Key key})
      : super(key: key);

  CompetitionChartWidgetState createState() => CompetitionChartWidgetState();
}

class CompetitionChartWidgetState extends State<CompetitionChartWidget> {
  List<List<dynamic>> data = [];
  bool isExist = false;

  loadAsset() async {
    final myData = await StorageUtils().loadCsv("20200930_각군학교경쟁률.csv");
    data = myData;
    if (this.mounted) {
        setState(() {
         //Your code
        });
}

    return data;
  }

  checkExist(name){
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
    // List<List<int>> competition_data = widget.competition_data;
    // List<String>school_data_=widget.school_data;
    Size size = MediaQuery.of(context).size;
    checkExist(school_name);
    return Container(
        child: Container(
            height: size.height,
            width: size.width,
            child: data.length == 0
                ? Center(child: CircularProgressIndicator())
                : !isExist ? Container() : OrdinalComboBarLineChartWidget.withSampleData(
                    filter_competiton(school_name))),

    );
  }
}
