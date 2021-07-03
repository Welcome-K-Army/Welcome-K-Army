import 'package:Army/model/calendar/event.dart';
import 'package:Army/page/calendar/school_event_viewing_page.dart';
import 'package:flutter/material.dart';
import 'package:Army/storage/storage.dart';
import '../../constants.dart';
import 'package:Army/services/helper.dart';
class SchoolEventListPage extends StatefulWidget {
  final String schoolName;
  SchoolEventListPage({Key key, this.schoolName}) : super(key: key);
  SchoolEventListPageState createState() => SchoolEventListPageState();
}
class SchoolEventListPageState extends State<SchoolEventListPage> {
  List<List<dynamic>> data;
  List<String> idxList = [];
  bool isLoaded = false;
  void loadData(String schoolName) async {
    data = await StorageUtils().loadCsv("curriculums/" + schoolName + " 일정.csv");
    for (int i = 1; i < data.length; i++) {
      if (!idxList.contains(data[i][0].toString().trim())) {
        idxList.add(data[i][0].toString().trim());
      }
    }
    setState(() {
      isLoaded = true;
    });
  }
  @override
  void initState() {
    loadData(widget.schoolName);
    super.initState();
  }
  Widget buildCard(String idxName) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
      child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: ExpansionTile(
              title: Text(
                idxName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
              ),
              initiallyExpanded: false,
              backgroundColor: Colors.white,
              children: data.toList().map((List<dynamic> row) {
                // Divider(
                //   height: 3,
                //   color: Colors.black38,
                // ),
                if (row[0].toString().trim() == idxName) {
                  return Column(
                    children: [
                      Divider(
                        height: 5,
                        color: Colors.black38,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Container(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //Text(row[1]),
                                SingleChildScrollView(
                                  // child: Container(
                                  //   alignment: Alignment.centerRight,
                                  //   width: 200,
                                  child: InkWell(
                                      onTap: () {
                                        showAlertDialog(context, row[1], "시작시간: "+ row[2] + "\n" +"종료시간: "+ row[3]);

                                        //
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(builder: (context) => SchoolEventViewingPage(event: event)),
                                        // );
                                      },
                                      child: Text(row[1])),
                                  // ),
                                )
                              ],
                            ),
                          ))
                    ],
                  );
                } else {
                  return Container();
                }
              }).toList(),
            ),
          )),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                )),
            backgroundColor: Color(COLOR_PRIMARY),
            title: Center(child: Text(widget.schoolName)),
            leading: Container(),
            leadingWidth: 0),
        body: !isLoaded
            ? Center(
          child: CircularProgressIndicator(),
        )
            : SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                  children: idxList.map((indexName) {
                    return buildCard(indexName);
                  }).toList()
                // children: data.map((line) => Text(line.toString())).toList(),
              ),
            )));
  }
}