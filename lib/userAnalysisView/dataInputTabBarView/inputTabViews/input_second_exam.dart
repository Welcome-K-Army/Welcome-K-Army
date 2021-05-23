import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './title_with_textfield.dart';

class InputSecondExam extends StatefulWidget {
  InputSecondExam();

  InputSecondExamState createState() => InputSecondExamState();
}

class InputSecondExamState extends State<InputSecondExam> {
  final List<String> bodyScores = [
    "키",
    "몸무게"
  ];

  final List<String> healthScores = [
    "오래달리기",
    "팔굽혀펴기",
    "윗몸일으키기"
  ];

  final List<String> interviewScores = [
    "점수"
  ];
  final List<String> historyScores = [
    "급수"
  ];

  InputSecondExamState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TitleWithTextfield(width: size.width, title: "신체검사", hint: "100", scoreList: bodyScores),
            TitleWithTextfield(width: size.width, title: "체력검정", hint: "100", scoreList: healthScores),
            TitleWithTextfield(width: size.width, title: "면접", hint: "100", scoreList: interviewScores),
            TitleWithTextfield(width: size.width, title: "한국사", hint: "100", scoreList: historyScores),
          ],
        ));
  }
}
