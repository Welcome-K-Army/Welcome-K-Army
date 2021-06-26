import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import '../School.dart';
import '../data.dart';
import '../../detailView/detail_main.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SearhBar extends StatefulWidget {
  @override
  _SearhBarState createState() => _SearhBarState();
}

class _SearhBarState extends State<SearhBar> {
  TextEditingController controller = TextEditingController();
  List<School> dataSet = fillData();
  School data_filtered = null;
  List<School> result_data = [];
  FToast fToast;
  // String _searchResult;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

  void showErrorToast() {
    fToast.showToast(
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(10)),
          child: Text(
            "해당 결과가 없습니다.",
            style: TextStyle(color: Colors.white),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  void submit() async {
    if (data_filtered == null) {
      showErrorToast();
      return;
    }
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailView(
              arguments: Arguments(
                  data_filtered.name,
                  data_filtered.address,
                  data_filtered.number,
                  data_filtered.web_address,
                  data_filtered.image,
                  data_filtered.pdfurl,
                  data_filtered.web_address_detail,
                  data_filtered.one,
                  data_filtered.two,
                  data_filtered.three,
                  data_filtered.four))),
    );
    data_filtered = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.search),
              iconSize: 20,
              onPressed: submit,
            ),
            Expanded(
              child:TextField(
                textCapitalization: TextCapitalization.words,
                controller: controller,
                decoration: InputDecoration(
                  hintText: '이름으로 검색',
                ),
                onSubmitted: (value) {
                  for (int i = 0; i < dataSet.length; i++) {
                    if (value == dataSet[i].name) {
                      data_filtered = dataSet[i];
                    }
                  }
                  submit();
                },
              ),
            )
          ],
        )
      ),
    );
  }
}
