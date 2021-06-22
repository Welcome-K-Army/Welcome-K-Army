import 'School.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

List<School> fillData() {
  List<School> lists = [];
  lists.add(
    new School(
      idx: 1, name: "육군사관학교",
       address: "서울특별시 노원구 공릉2동 화랑로 574",
        number: "+82221970114", 
        web_address: "https://www.kma.ac.kr:461/", 
        image: "lib/assets/image/army.png",
        pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf",
        web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do",
        latlng: LatLng(37.623787, 127.098831), 
        category: Categories.Army, 
        type: Types.Cadets, 
        age: Ages.A_17_21, 
        classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
        ));
  lists.add(
    new School(
      idx: 2, 
      name: "해군사관학교", 
      address: "경상남도 창원시 진해구 태평동 중원로 1", 
      number: "+82555491082", 
      web_address: "http://www.navy.ac.kr", 
      image: "lib/assets/image/sea.png",
      pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf", 
      web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do",
      latlng: LatLng(35.127210, 128.662695), 
      category: Categories.Navy, 
      type: Types.Cadets, 
      age: Ages.A_17_21, 
      classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
      ));
  lists.add(
    new School(
      idx: 3, 
      name: "공군사관학교", 
      address: "충청북도 청주시 상당구 남일면 단재로 635", 
      number: "+82432906114", 
      web_address: "https://rokaf.airforce.mil.kr/afa/index.do", 
      image: "lib/assets/image/air.png",
      pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf",
      web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do", 
      latlng: LatLng(36.579458, 127.524334), 
      category: Categories.AirForce, 
      type: Types.Cadets, 
      age: Ages.A_17_21, 
      classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
    ));
  lists.add(
    new School(idx: 4, 
    name: "육군 3사관학교", 
    address: "경상북도 영천시 고경면 호국로 495", 
    number: "+82543303114", 
    web_address: "https://www.kaay.mil.kr:458/", 
    image: "lib/assets/image/three.png",
    pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf",
    web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do", 
    latlng: LatLng(35.986904, 128.988485), 
    category: Categories.Army, 
    type: Types.Cadets, 
    age: Ages.A_19_25, 
    classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
    ));
  lists.add(
    new School(idx: 5, 
    name: "국군간호사관학교", 
    address: "대전광역시 유성구 자운동 자운로 90", 
    number: "+8216889171", 
    web_address: "http://www.afna.ac.kr", 
    image: "lib/assets/image/nurse.png",
    pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf",
    web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do", 
    latlng: LatLng(36.398094, 127.349693), 
    category: Categories.All, 
    type: Types.Cadets, 
    age: Ages.A_17_21, 
    classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
    ));
  lists.add(
    new School(idx: 6, 
    name: "육군학생군사학교", 
    address: "충청북도 괴산군 괴산읍 문무로 177", 
    number: "+82438346043", 
    web_address: "https://www.armyofficer.mil.kr" ,
    image:"lib/assets/image/rotc.png",
    pdfurl:"https://www.kma.ac.kr:461/sites/kma/2022%ED%95%99%EB%85%84%EB%8F%84(82%EA%B8%B0)%EC%9C%A1%EA%B5%B0%EC%82%AC%EA%B4%80%EC%83%9D%EB%8F%84%EB%AA%A8%EC%A7%91%EC%9A%94%EA%B0%95.pdf",
    web_address_detail:"https://www.kma.ac.kr:461/kma/2093/subview.do", 
    latlng: LatLng(36.821519, 127.805987), 
    category: Categories.Army, 
    type: Types.CadetCandidate, 
    age: Ages.A_20_27, 
    classes: Classes.Officer,
        one:50,
        two:100,
        three:200,
        four:10,
    ));

  return lists;
}
