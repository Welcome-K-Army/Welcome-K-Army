import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  Function widgetSetStatus;
  Color firstButtonColor;
  Color secondButtonColor;
  Color borderColor;
  CustomToggleButton({this.widgetSetStatus, this.firstButtonColor, this.secondButtonColor, this.borderColor});

  _CustomToggleButtonState createState() => _CustomToggleButtonState(firstButtonColor: firstButtonColor, secondButtonColor: secondButtonColor, borderColor: borderColor);
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  Function widgetSetStatus;

  Color firstButtonColor;
  Color secondButtonColor;
  Color borderColor;

  Color trueButtonColor;
  Color falseButtonColor;

  _CustomToggleButtonState({this.widgetSetStatusl, this.firstButtonColor, this.secondButtonColor, this.borderColor}) {
    this.trueButtonColor = this.firstButtonColor;
    this.falseButtonColor = this.secondButtonColor;
  }


  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
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
                  widgetSetStatus();
                  setState(() {
                    firstButtonColor = trueButtonColor;
                    secondButtonColor = falseButtonColor;
                  });
                },
              ),
              SizedBox(width: 15),
              ElevatedButton(
                style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                  backgroundColor: MaterialStateProperty.all<Color>(secondButtonColor), 
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22.0), 
                    side: BorderSide(color: secondButtonColor)
                  ))),
                onPressed: () {
                  setState(() {
                    widgetSetStatus();
                    firstButtonColor = falseButtonColor;
                    secondButtonColor = trueButtonColor;
                  });
                },
              ),
            ])));
  }
}
