import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  bool status;
  Color firstButtonColor;
  Color secondButtonColor;
  Color borderColor;
  CustomToggleButton({this.status, this.firstButtonColor, this.secondButtonColor, this.borderColor});

  _CustomToggleButtonState createState() => _CustomToggleButtonState(status: status, firstButtonColor: firstButtonColor, secondButtonColor: secondButtonColor, borderColor: borderColor);
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  _CustomToggleButtonState({this.status, this.firstButtonColor, this.secondButtonColor, this.borderColor});

  bool status;

  Color firstButtonColor;
  Color secondButtonColor;
  Color borderColor;

  Color trueButtonColor = firstButtonColor;
  Color falseButtonColor = secondButtonColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: 
        Container(
            padding: EdgeInsets.all(4),
            width: 170,
            decoration: BoxDecoration(border: Border.all(color: borderColor), borderRadius: BorderRadius.circular(22.0)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(firstButtonColor),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22.0),
                      side: BorderSide(color: firstButtonColor),
                    ))),
                onPressed: () {
                  setState(() {
                    status = false;
                    firstButtonColor = trueButtonColor;
                    secondButtonColor = falseButtonColor;
                  });
                },
              ),
              SizedBox(width: 15),
              ElevatedButton(
                style: ButtonStyle(foregroundColor: MaterialStateProperty.all<Color>(Colors.white), backgroundColor: MaterialStateProperty.all<Color>(secondButtonColor), shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0), side: BorderSide(color: secondButtonColor)))),
                onPressed: () {
                  setState(() {
                    status = true;
                    firstButtonColor = falseButtonColor;
                    secondButtonColor = trueButtonColor;
                  });
                },
              ),
            ]))
      ]),
    );
  }
}
