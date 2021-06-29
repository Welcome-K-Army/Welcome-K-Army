import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:thumbnailer/thumbnailer.dart';

import 'package:Army/constants.dart';
import 'package:Army/model/home/pdf_item.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';
import 'package:Army/services/firebaseUtil.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  String school;
  List<String> schools = ["육군사관학교", "해군사관학교", "공군사관학교", "국군간호사관학교", "육군3사관학교"];
  List<List<String>> schoolNewsItems = [[],[],[],[],[]];
  List<List<String>> schoolNewsItemTitleList = [
    ["육사신보 제625호","육사신보 제626호","육사신보 제627호","육사신보 제628호","육사신보 제629호"],
    ["해사학보 제308호","해사학보 제309호","해사학보 제310호","해사학보 제311호","해사학보 제312호"],
    ["공사신문 제353호","공사신문 제354호","공사신문 제355호","공사신문 제356호","공사신문 제357호"],
    ["국간사학보 제123호","국간사학보 제124호","국간사학보 제125호","국간사학보 제126호","국간사학보 제127호"],
    ["충성대신문 제184호","충성대신문 제185호","충성대신문 제186호","충성대신문 제187호","충성대신문 제188호"]
  ];
  List<List<PdfItem>> pdfItems = [[],[],[],[],[]];
  ///Get the PDF document as bytes.
  Future loadUrl(String schools, String title, String path, String filetype) async {
    final url = await FireStoreUtils().getFileUrl("$path/news/$schools/$title.$filetype");
    print(url);
    return url;
  }

  loadUrlList() {
    for (int i = 0; i < schools.length; i++) {
      for (int j = 0; j < schoolNewsItemTitleList[i].length; j++) {
        loadUrl(schools[i], schoolNewsItemTitleList[i][j], 'images', 'png')
            .then((pngUrl) {
          schoolNewsItems[i].add(pngUrl);
        });
        loadUrl(schools[i], schoolNewsItemTitleList[i][j], 'pdf', 'pdf')
            .then((pdfUrl) {
          pdfItems[i].add(
              PdfItem(url: pdfUrl, title: schoolNewsItemTitleList[i][j]));
        });
      }
    }
  }
  @override
  void initState() {
    school = schools[0];
    loadUrlList();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: buildDropdownBtn()),
      body: buildNewsCard(school, size),
    );
  }

  Widget buildDropdownBtn() {
    return DropdownButtonHideUnderline(
        child: DropdownButton(
      isExpanded: true,
      iconSize: 24,
      elevation: 16,
      underline: Container(
          decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.black38))),
      dropdownColor: Colors.white,
      style: TextStyle(
        color: Colors.black,
      ),
      value: school,
      onChanged: (val) => setState(() => school = val), // 이 부분에 네트워크 pdf 연결코드 넣기
      items: [
        for (var sch in schools)
          DropdownMenuItem(
            value: sch,
            child: SizedBox(
              child: Text(
                sch.toString(),
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black87,
                ),
              ),
            ),
          ),
      ],
    )); // Container
  }

  Widget buildNewsCard(String school, Size size) {
    int index = schools.indexOf(school);
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: pdfItems[index].length,
        itemBuilder: (BuildContext context, int j) {
          return Padding(
              padding: EdgeInsets.all(10.0),
              child: Card(
                  child: Column(children: <Widget>[
                Padding(
                    padding: EdgeInsets.all(10.0),
                    child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  PdfViewingWidget(pdfItem: pdfItems[index][j])));
                        },
                      child: Image.network(schoolNewsItems[index][j], height:300))),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text(pdfItems[index][j].title,
                        style: TextStyle(fontWeight: FontWeight.bold))),
              ])));
        },
        separatorBuilder: (context, index) {
          return const Divider(
            color: Colors.black12,
            height: 10,
            thickness: 1,
            indent: 15,
            endIndent: 15,
          );
        });
  }
}
