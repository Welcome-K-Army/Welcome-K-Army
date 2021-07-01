import 'package:Army/model/home/pdf_item.dart';
import 'package:flutter/material.dart';
import 'package:Army/services/firebaseUtil.dart';

class PdfProvider extends ChangeNotifier {
  bool newsLoading=true;
  bool admissionLoading=true;
  List<String> schools = ["육군사관학교", "해군사관학교", "공군사관학교", "국군간호사관학교", "육군3사관학교"];
  List<String> schoolAdmission = ["육군사관학교", "해군사관학교", "공군사관학교", "국군간호사관학교", "육군3사관학교", "육군학생군사학교"];
  List<List<String>> schoolAdmissionItemTitleList = [
    ["2022년도 육군사관학교 모집요강"],
    ["2022학년도 해군사관학교 모집요강"],
    ["2022년도 공군사관학교 모집요강"],
    ["2022년도 국군간호사관학교 모집요강"],
    ["2022년도 육군3사관학교 모집요강", "2023년도 육군3사관학교 모집요강"],
    ["2021년도 육군학생군사학교 모집요강"]
  ];
  List<List<String>> schoolAdmissionItems = [
    [null],
    [null],
    [null],
    [null],
    [null, null],
    [null]
  ];
  List<List<PdfItem>> schoolAdmissionPdfItems = [
    [null],
    [null],
    [null],
    [null],
    [null, null],
    [null]
  ];
  List<List<String>> schoolNewsItemTitleList = [
    ["육사신보 제625호","육사신보 제626호","육사신보 제627호","육사신보 제628호","육사신보 제629호"],
    ["해사학보 제308호","해사학보 제309호","해사학보 제310호","해사학보 제311호","해사학보 제312호"],
    ["공사신문 제353호","공사신문 제354호","공사신문 제355호","공사신문 제356호","공사신문 제357호"],
    ["국간사학보 제123호","국간사학보 제124호","국간사학보 제125호","국간사학보 제126호","국간사학보 제127호"],
    ["충성대신문 제184호","충성대신문 제185호","충성대신문 제186호","충성대신문 제187호","충성대신문 제188호"]
  ];
  List<List<String>> schoolNewsItems = [
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null]
  ];
  List<List<PdfItem>> schoolNewsPdfItems = [
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null],
    [null, null, null, null, null]
  ];

  Future loadUrl(String path,String view,String schools, String title,  String filetype) async {
    final url = await FireStoreUtils().getFileUrl("$path/$view/$schools/$title.$filetype");
    return url;
  }

  Future loadAdmissionUrl(String path,String view,String title,  String filetype) async {
    final url = await FireStoreUtils().getFileUrl("$path/$view/$title.$filetype");
    return url;
  }

  loadUrlList() {
    for (int i = 0; i < schools.length; i++) {
      for (int j = 0; j < schoolNewsItemTitleList[i].length; j++) {
        loadUrl(
            'images', "news", schools[i], schoolNewsItemTitleList[i][j], 'png')
            .then((pngUrl) {
          loadUrl(
              'pdf', "news", schools[i], schoolNewsItemTitleList[i][j], 'pdf')
              .then((pdfUrl) {
            schoolNewsItems[i][j] = pngUrl;
            schoolNewsPdfItems[i][j] =
                PdfItem(url: pdfUrl, title: schoolNewsItemTitleList[i][j]);
            if (i == schools.length - 1 &&
                j == schoolNewsItemTitleList[i].length - 1) {
              newsLoading = false;
            }
          });
        });
      }
    }
    for (int i = 0; i < schoolAdmission.length; i++) {
      for (int j = 0; j < schoolAdmissionItemTitleList[i].length; j++) {
        loadAdmissionUrl('images',"admission",schoolAdmissionItemTitleList[i][j],  'png')
            .then((pngUrl) {
          loadAdmissionUrl( 'pdf',"admission",schoolAdmissionItemTitleList[i][j], 'pdf')
              .then((pdfUrl) {
            schoolAdmissionItems[i][j] = pngUrl;
            schoolAdmissionPdfItems[i][j] =
                PdfItem(url: pdfUrl, title: schoolAdmissionItemTitleList[i][j]);
            if(i==schools.length-1&&j==schoolAdmissionItemTitleList[i].length-1){
              admissionLoading=false;
            }
          });
        });
      }

      notifyListeners();
    }
  }
}
