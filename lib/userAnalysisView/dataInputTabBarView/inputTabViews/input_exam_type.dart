import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'custom_drop_down_button.dart';

class InputExamType extends StatefulWidget {
  InputExamTypeState createState() => new InputExamTypeState();
}

class InputExamTypeState extends State<InputExamType> with SingleTickerProviderStateMixin {
  final List<String> typeItems = [
    "사관학교",
    "학군단",
    "부사관"
  ];

  final List<String> typeAcademyItems = [
    "고등학교 학교장 추천",
    "적성 우수",
    "종합 선발",
    "독립유공자 손자녀 및 국가유공자 자녀",
    "농어촌 학생",
    "기초생활 수급자 및 차상위 계층",
    "재외국민 자녀"
  ];

  bool status = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: 200,
        child: Column(
          children: [
            CustomDropDownButton(dropdownValue: typeItems[0], items: typeItems),
            Container(
                child:
                  status
                  ?  CustomDropDownButton(dropdownValue: typeAcademyItems[0], items: typeAcademyItems)
                  : Container(),
                ),
          ],
        ));
  }
}
