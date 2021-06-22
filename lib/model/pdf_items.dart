import 'package:flutter/material.dart';
import '../page/pdf_viewing_page.dart';

class PdfItems {
  List<String> items;
  List<String> itemsTitle;

  PdfItem({this.items, this.itemsTitle});
  
  factory PdfItems.fromUrl(Map<String, dynamic) parsedJson {
    return new PdfItems(items: parsedJson['items'] ?? "", itemsTitle: parsedJson['itemsTitle'] ?? "");
  }

}
