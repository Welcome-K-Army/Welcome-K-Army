import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

class CustomSwitch extends StatefulWidget {
  bool status;
  CustomSwitch({this.status});
  @override
  _CustomSwitchState createState() => _CustomSwitchState(status: status);
}

class _CustomSwitchState extends State<CustomSwitch> { 
  _CustomSwitchState({this.status});

  bool status;
  Color _textColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlutterSwitch(
        activeText: "Pie",
        inactiveText: "Radar",
        width: 150.0,
        height: 55.0,
        toggleSize: 75.0,
        value: status,
        borderRadius: 30.0,
        padding: 1.0,
        toggleColor: Color.fromRGBO(225, 225, 225, 1),
        /*
        switchBorder: Border.all(
          color: Color(0xFF0C9869),
          width: 6.0,
        ),
          toggleBorder: Border.all(
            color: Color.fromRGBO(2, 107, 206, 1),
            width: 5.0,
          ),
          */
        activeColor: Color(0xFF0C9869),
        inactiveColor: Color(0xFFEF9A9A),
        showOnOff: true,
        onToggle: (val) {
          setState(() {
            status = val;
          });
        },
      ),
    );
  }
}
