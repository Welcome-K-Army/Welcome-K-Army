import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import '../search_controller.dart';
import '../School.dart';
import '../data.dart';
import '../../detailView/detail_main.dart';

class SearhBar extends StatefulWidget {
  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {
  TextEditingController controller = TextEditingController();
  List<School> dataSet = fillData();
  School data_filtered;
  List<School> result_data = [];
  // String _searchResult;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(3),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: TextField(
          textCapitalization: TextCapitalization.words,
          controller: controller,
          decoration: InputDecoration(hintText: 'Search Location', icon: Icon(Icons.search)),
          onChanged: (value) async {
            setState(() {
              // _searchResult=value;
              for (int i = 0; i <= dataSet.length; i++) {
                if (value == dataSet[i].name) {
                  data_filtered=dataSet[i];
                }
              } //for
            });
          },
          onTap: () {
            setState(
              () async {
                final arguments = Arguments(data_filtered.name, data_filtered.address, data_filtered.number, data_filtered.web_address, data_filtered.image, data_filtered.pdfurl, data_filtered.web_address_detail, data_filtered.one, data_filtered.two, data_filtered.three, data_filtered.four);
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailView(arguments: arguments)),
                );
                // controller.clear();
                data_filtered = '';
              },
            );
          },
        ),
      ),
    );
  }
}
