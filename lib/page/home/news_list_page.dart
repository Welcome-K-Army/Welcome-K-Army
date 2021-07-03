import 'dart:typed_data';
import 'package:Army/provider/pdf_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Army/constants.dart';
import 'package:Army/widget/home/pdf_viewing_widget.dart';
import 'package:Army/widget/home/dropdown_widget.dart';

class NewsListPage extends StatefulWidget {
  @override
  NewsListPageState createState() => NewsListPageState();
}

class NewsListPageState extends State<NewsListPage> {
  String school = "육군사관학교";
  double height = 100;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pdfProvider = Provider.of<PdfProvider>(context);
    return Scaffold(
      appBar: AppBar(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          )),
          backgroundColor: Color(COLOR_PRIMARY),
          title: Center(child: Text("학교 뉴스")),
          leading: Container(),
          leadingWidth: 0),
      body: pdfProvider.newsLoading
          ? Center(child: CircularProgressIndicator())
          : buildNewsCard(school, size, context),
    );
  }

  Widget buildDropdownBtn(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final pdfProvider = Provider.of<PdfProvider>(context);

    return Padding(
        padding: EdgeInsets.all(10.0),
        child: DropdownWidget<String>(
          child: Text(
              school,
          ),
          onChange: (String value, int index) {
            setState(() {
              school = value;
            });
          },

          dropdownButtonStyle: DropdownButtonStyle(
            width: size.width - 36.0,
            height: 40,
            elevation: 3,
            backgroundColor: Colors.white,
            primaryColor: Colors.black87,
          ),
          dropdownStyle: DropdownStyle(
              borderRadius: BorderRadius.circular(8),
              elevation: 3,
              padding: EdgeInsets.all(5),
              color: Colors.white),
          items: pdfProvider.schools
              .asMap()
              .entries
              .map(
                (item) => DropdownItem<String>(
                  value: item.value,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(item.value)),
                  ),
                ),
              )
              .toList(),
        ));
  }

  Widget buildNewsCard(String school, Size size, BuildContext context) {
    final pdfProvider = Provider.of<PdfProvider>(context);
    int index = pdfProvider.schools.indexOf(school);
    int length = pdfProvider.schoolNewsPdfItems[index].length + 1;
    return ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: length,
        itemBuilder: (BuildContext context, int j) {
          if (j == 0)
            return buildDropdownBtn(context);
          else
            return Padding(
                padding: EdgeInsets.all(10.0),
                child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: Column(children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(10.0),
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        PdfViewingWidget(
                                            pdfItem: pdfProvider
                                                    .schoolNewsPdfItems[index]
                                                [length - (j+1)])));
                              },
                              child: Image.network(
                                  pdfProvider.schoolNewsItems[index]
                                      [length - (j+1)],
                                  height: 300))),
                      Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: Text(
                              pdfProvider
                                  .schoolNewsPdfItems[index][length - (j+1)]
                                  .title,
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
