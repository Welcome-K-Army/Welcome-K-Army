import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:provider/provider.dart';

import 'custom_drop_down_button.dart';
import 'input_type_multi_provider.dart';

class InputType extends StatefulWidget {
  InputTypeState createState() => new InputTypeState();
}

class InputTypeState extends State<InputType> with SingleTickerProviderStateMixin {
  final List<String> typeItems = [
    "육군",
    "해군",
    "공군"
  ];

  final List<String> instituteItems = [
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
    TypeStatus typeStatus = Provider.of<TypeStatus>(context);
    InstitutionStatus institutionStatus = Provider.of<InstitutionStatus>(context);

    return Container(
        height: size.height,
        child: Column(
          children: [
            CustomDropDownButton(height: size.height / 10, width: size.width, dropdownValue: typeItems[0], items: typeItems),
            CustomDropDownButton(height: size.height / 10, width: size.width, dropdownValue: instituteItems[0], items: instituteItems),
            Container(
              child: institutionStatus.getStatus() ? CustomDropDownButton(height: size.height / 10, width: size.width, dropdownValue: typeAcademyItems[0], items: typeAcademyItems) : Container(),
            ),
          ],
        ));
  }
}
