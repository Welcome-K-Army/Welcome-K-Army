import 'package:flutter/material.dart';
import 'package:Army/storage/storage.dart';

class CurriculumPage extends StatefulWidget {
  final String schoolName;
  CurriculumPage({Key key, this.schoolName}) : super(key: key);

  CurriculumPageState createState() => CurriculumPageState();
}

class CurriculumPageState extends State<CurriculumPage> {
  List<List<dynamic>> data;
  List<String> idxList = [];
  bool isLoaded = false;

  void loadData(String schoolName) async {
    data = await StorageUtils().loadCsv("curriculums/test.csv");
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
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.black87),
              ),
              initiallyExpanded: false,
              backgroundColor: Colors.white,
              children: data.toList().map((List<dynamic> row) {
                // Divider(
                //   height: 3,
                //   color: Colors.black38,
                // ),
                if(row[0].toString().trim() == idxName){
                  return Column(children: [
                  Divider(
                    height: 5,
                    color: Colors.black38,
                    indent: 10,
                    endIndent: 10,
                  ),
                    Container(
                        width: double.infinity,
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(row[1]),
                              Text(row[2])
                            ],
                          ),
                        ))
                  ],) ;
                }
                else{
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
            child: Column(
                children: idxList.map((indexName) {
              return buildCard(indexName);
            }).toList()
                // children: data.map((line) => Text(line.toString())).toList(),
                ),
          );
  }
}
