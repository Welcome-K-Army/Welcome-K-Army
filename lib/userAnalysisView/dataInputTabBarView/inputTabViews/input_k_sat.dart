import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import './custom_textfield.dart';

class InputKSAT extends StatefulWidget {
  InputKSAT();

  InputKSATState createState() => InputKSATState();
}

class InputKSATState extends State<InputKSAT> {
  final List<String> koreanLanguageAndMathAndInquiryScores = [
    "표준점수",
    "전국 최고 표준점수"
  ];

  final List<String> englishAndHistoryScores = [
    "등급"
  ];

  InputKSATState();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            CustomTextfield(width: size.width, title: "국어", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            CustomTextfield(width: size.width, title: "수학", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            CustomTextfield(width: size.width, title: "영어", hint: "100", scoreList: englishAndHistoryScores),
            CustomTextfield(width: size.width, title: "한국사", hint: "100", scoreList: englishAndHistoryScores),
            CustomTextfield(width: size.width, title: "탐구 1", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores),
            CustomTextfield(width: size.width, title: "탐구 2", hint: "100", scoreList: koreanLanguageAndMathAndInquiryScores)
          ],
        ));
  }
}
