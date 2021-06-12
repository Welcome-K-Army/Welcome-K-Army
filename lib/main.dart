import 'dart:async';

import 'package:flutter/material.dart';
import 'mapView/mapScreen/MapSample.dart'; // Api 사용 예시
import 'mapView/filterScreen/FilterScreen.dart'; // 학교 정보 필터링 예시

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filtering demo',
      home: FilterScreen(),
      theme: ThemeData(
        bottomSheetTheme:
            BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
      ),
    );
  }
}
