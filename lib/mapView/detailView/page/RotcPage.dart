import 'package:Army/constants.dart';
import 'package:flutter/material.dart';
import 'package:Army/storage/storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class RotcPage extends StatefulWidget {
  RotcPage({Key key}) : super(key: key);

  RotcPageState createState() => RotcPageState();
}

class RotcPageState extends State<RotcPage> {
  List<List<dynamic>> data;
  List<String> idxList = [];
  bool isLoaded = false;
  FToast fToast;

  void loadData() async {
    data = await StorageUtils().loadCsv("rotcList.csv");
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
    loadData();
    fToast = FToast();
    fToast.init(context);
    super.initState();
  }

  void showCopyToast() {
    fToast.showToast(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "복사되었습니다.",
            style: TextStyle(color: Colors.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  Widget inner(String d) {
    return Column(children: [
      Divider(
        height: 5,
        color: Colors.black38,
        indent: 10,
        endIndent: 10,
      ),
      ListTile(
        visualDensity: VisualDensity(vertical: -4),
        title: Text(
          d,
          style: TextStyle(color: Colors.black87, fontSize: 14),
        ),
        trailing: TextButton(
            child: Icon(
              Icons.copy,
              color: Color(COLOR_PRIMARY),
            ),
            onPressed: () {
              showCopyToast();
              Clipboard.setData(ClipboardData(text: d));
            }),
      ),
    ]);
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              backgroundColor: Colors.white,
              children: data.toList().map((List<dynamic> row) {
                if (row[0].toString().trim() == idxName) {
                  return Padding(
                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                      child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: ExpansionTile(
                                backgroundColor: Colors.white,
                                title: Text(
                                  row[1],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black87),
                                ),
                                children: [
                                  inner(row[2]),
                                  inner(row[3]),
                                  inner(row[4]),
                                  inner(row[5]),
                                ],
                              ))));
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
    return !isLoaded
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
          ));
  }
}
