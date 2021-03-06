import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

import 'package:Army/services/firebaseUtil.dart';

class StorageUtils {
  Future loadCsv(String filename) async {
    final myData = await rootBundle.loadString("lib/storage/csvFiles/$filename");
    List<List<dynamic>> csvTable = CsvToListConverter(eol:'\n').convert(myData);
    return csvTable;
  }

  Future<dynamic> loadJson(String fileurl) async {
  }
}