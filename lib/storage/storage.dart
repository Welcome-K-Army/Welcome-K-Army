import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:csv/csv.dart';

import 'package:Army/services/authenticate.dart';

class StorageUtils {
  Future<List> loadCsv(String filename) async {
    final myData = await rootBundle.loadString("lib/storage/$filename");
    print(myData);
    List<List<dynamic>> csvTable = CsvToListConverter().convert(myData);
    print(csvTable);
    return csvTable;
  }

  Future<dynamic> loadJson(String fileurl) async {
  }
}
