import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool status2 = true;

  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlutterSwitch(
          activeText: "Pie",
          inactiveText: "Radar",
          width: 100.0,
          height: 55.0,
          toggleSize: 45.0,
          value: status2,
          borderRadius: 30.0,
          padding: 2.0,
          toggleColor: Color.fromRGBO(225, 225, 225, 1),
          switchBorder: Border.all(
            color: Color.fromRGBO(2, 107, 206, 1),
            width: 6.0,
          ),
          toggleBorder: Border.all(
            color: Color.fromRGBO(2, 107, 206, 1),
            width: 5.0,
          ),
          activeColor: Color.fromRGBO(51, 226, 255, 1),
          inactiveColor: Colors.black38,
          showOnOff: true,
          onToggle: (val) {
            setState(() {
              status2 = val;
            });
          },
        ),
        Container(
          alignment: Alignment.centerRight,
          child: Text(
            "Value: $status2",
          ),
        ),
      ],
    );
  }
}
