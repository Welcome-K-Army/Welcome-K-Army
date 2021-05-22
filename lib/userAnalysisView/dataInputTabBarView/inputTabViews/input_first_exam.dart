import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './custom_textfield.dart';

class InputFirstExam extends StatefulWidget {
  InputFirstExam();

  InputFirstExamState createState() => InputFirstExamState();
}

class InputFirstExamState extends State<InputFirstExam> {
  final List<String> languageScores = [
    "원점수",
    "평균점수",
    "표준편차"
  ];

  final List<String> mathScores = [
    "공통과목 원점수",
    "공통과목 평균점수",
    "공통과목 표준편차",
    "선택과목 원점수",
    "선택과목 평균점수",
    "선택과목 표준편차",
    "선택과목 조정점수 평균",
    "선택과목 조정점수 표준편차"
  ];

  InputFirstExamState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomTextfield(width: size.width, title: "국어", hint: "100", scoreList: languageScores),
          ],
        ));
  }
}
