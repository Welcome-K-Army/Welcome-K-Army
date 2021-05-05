import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';

import 'package:intl/intl.dart';

final List<Person> personList = [
  new Person(name: '장성호'),
  new Person(name: '나부겸'),
  new Person(name: '신민석'),
  new Person(name: '김민준'),
];

class Person {
  String name;

  Notice({this.name});
}
