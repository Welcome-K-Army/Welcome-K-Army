import 'package:flutter/material.dart';
import 'DropDownButtonWidget.dart';

class DropDownButtonList extends StatelessWidget {
  List<String> _categories = ['육군', '공군', '해군'];
  List<String> _classes = ['장교', '부사관', '용사'];
  List<String> _types = ['사관생도', '사관후보생', '전문사관', '기타'];
  List<String> _ages = [
    '17세 이상 21세 미만',
    '19세 이상 25세 미만',
    '25세 이상 28세 미만',
    '28세 이상 31세 미만'
  ];
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropDownButtonWidget(
            dropDownItems: _categories,
            hint: "군종",
          ),
          DropDownButtonWidget(
            dropDownItems: _classes,
            hint: "계급",
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          DropDownButtonWidget(
            dropDownItems: _types,
            hint: "임관유형",
          ),
          DropDownButtonWidget(
            dropDownItems: _ages,
            hint: "나이 (만)",
          )
        ],
      )
    ]);
  }
}
