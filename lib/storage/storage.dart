import 'package:flutter/services.dart';
import 'package:csv/csv.dart';

import 'package:Army/services/authenticate.dart';

class StorageUtils {
  Future loadCsv(String filename) async {
    final myData = await rootBundle.loadString("lib/storage/csvFiles/$filename");
    List<List<String>> csvTable = CsvToListConverter(eol:'\n').convert(myData);
    return csvTable;
  }

  Future<String> loadJson(String fileurl) async {
  }
}