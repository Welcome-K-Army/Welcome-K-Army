import 'package:flutter/material.dart';

class PdfItem {
  String itemUrl;
  String title;

  PdfItem({this.itemUrl, this.title});

  /*
  factory PdfItem.fromUrl(Map<String, dynamic) parsedJson {
    return new PdfItem(items: parsedJson['items'] ?? "", itemsTitle: parsedJson['itemsTitle'] ?? "");
  }
  */
}
