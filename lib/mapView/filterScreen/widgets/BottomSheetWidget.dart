import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'BottomSheetButton.dart';
import 'DropDownButtonWidget.dart';
import 'Schools.dart';
import 'FilterData.dart';

class BottomSheetWidget extends StatefulWidget {
  @override
  _BottomSheetState createState() => _BottomSheetState();
}

class _BottomSheetState extends State<BottomSheetWidget> {
  String categories;
  String classes;
  String types;
  String ages;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 250,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.grey[300], spreadRadius: 5)
          ],
        ),
        child: ProxyProvider(
          create: (_) => FilterData(categories, classes, types, ages),
          child: Column(children: <Widget>[
            Container(
                height: 45,
                alignment: Alignment.centerLeft,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Text(
                  '상세검색',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropDownButtonWidget(
                  dropDownItems: ['육군', '공군', '해군'],
                  hint: "군종",
                ),
                DropDownButtonWidget(
                  dropDownItems: ['장교', '부사관', '용사'],
                  hint: "계급",
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropDownButtonWidget(
                  dropDownItems: ['사관', '사관생도', '전문사관', '기타'],
                  hint: "임관유형",
                ),
                DropDownButtonWidget(
                  dropDownItems: [
                    '17세 이상 21세 미만',
                    '19세 이상 25세 미만',
                    '25세 이상 28세 미만',
                    '28세 이상 31세 미만'
                  ],
                  hint: "나이 (만)",
                )
              ],
            ),
            BottomSheetButton(),
          ]),
        ));
  }
}
