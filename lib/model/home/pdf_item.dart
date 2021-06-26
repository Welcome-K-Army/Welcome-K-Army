import 'package:flutter/material.dart';

class PdfItem {
  String url;
  String title;

  PdfItem({this.url, this.title});

/*
  factory PdfItems.fromUrl(Map<String, dynamic) parsedJson {
    return new PdfItems(items: parsedJson['items'] ?? "", itemsTitle: parsedJson['itemsTitle'] ?? "");
  }
  */
}