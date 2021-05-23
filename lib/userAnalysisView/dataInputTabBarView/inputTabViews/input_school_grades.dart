import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './title_with_textfield.dart';

class InputSchoolGrades extends StatefulWidget {
  InputSchoolGrades();

  InputSchoolGradesState createState() => InputSchoolGradesState();
}

class InputSchoolGradesState extends State<InputSchoolGrades> {
  final List<String> koreanLanguageAndMathAndInquiryScores = [
    "표준점수",
    "전국 최고 표준점수"
  ];

  final List<String> englishAndHistoryScores = [
    "등급"
  ];

  InputSchoolGradesState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TitleWithTextfield(width: size.width, title: "국어", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            TitleWithTextfield(width: size.width, title: "수학", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            TitleWithTextfield(width: size.width, title: "영어", hint: "100", scoreList: englishAndHistoryScores),
            TitleWithTextfield(width: size.width, title: "한국사", hint: "100", scoreList: englishAndHistoryScores),
            TitleWithTextfield(width: size.width, title: "탐구 1", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            TitleWithTextfield(width: size.width, title: "탐구 2", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores)
          ],
        ));
  }
}
