import 'package:flutter/material.dart';
import '../page/pdf_viewing_page.dart';

class PdfItem {
  String item;
  String title;

  PdfItem({this.item, this.title});

  /*
  factory PdfItem.fromUrl(Map<String, dynamic) parsedJson {
    return new PdfItem(items: parsedJson['items'] ?? "", itemsTitle: parsedJson['itemsTitle'] ?? "");
  }
  */
}