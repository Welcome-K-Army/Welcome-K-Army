import 'School.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


List<School> fillData() {
  List<School> lists = [];
  lists.add(new School(
      idx: 1,
      name: "육군사관학교",
      address:"서울특별시 노원구 공릉2동 화랑로 574",
      number:"+82221970114",
      web_address:"https://www.kma.ac.kr:461/",
      image:Image.network('https://cdn.emetro.co.kr/data2/content/image/2020/03/05/.cache/512/20200305500291.jpg'),
      latlng: LatLng(37.623787, 127.098831),
      category: Categories.Army,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
      idx: 2,
      name: "해군사관학교",
      address:"경상남도 창원시 진해구 태평동 중원로 1",
      number:"+82555491082",
      web_address:"http://www.navy.ac.kr",
      image:Image.network('https://yt3.ggpht.com/ytc/AAUvwniuRX2hXDg-0zVJwNrfkp0ktLfg2kgXKI7ucuNK=s900-c-k-c0x00ffffff-no-rj'),
      latlng: LatLng(35.127210, 128.662695),
      category: Categories.Navy,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
      idx: 3,
      name: "공군사관학교",
      address:"충청북도 청주시 상당구 남일면 단재로 635",
      number:"+82432906114",
      web_address:"https://rokaf.airforce.mil.kr/afa/index.do",
      image:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTr04jBQ39g2YvAo6xpdvvD9IZUDnYjfkVzYw&usqp=CAU'),
      latlng: LatLng(36.579458, 127.524334),
      category: Categories.AirForce,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
    idx: 4,
    name: "육군 3사관학교",
    address:"경상북도 영천시 고경면 호국로 495",
    number:"+82543303114",
    web_address:"https://www.kaay.mil.kr:458/",
    image:Image.network('https://t1.daumcdn.net/cfile/tistory/241FB23F5950A3F504'),
    latlng: LatLng(35.986904, 128.988485),
    category: Categories.Army,
    type: Types.Cadets,
    age: Ages.A_19_25,
    classes: Classes.Officer));
  lists.add(new School(
      idx: 5,
      name: "국군간호사관학교",
      address:"대전광역시 유성구 자운동 자운로 90",
      number:"+8216889171",
      web_address:"http://www.afna.ac.kr",
      image:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9XUe_7rq-HmduKx39GFqD24wqGIl30LvsDg&usqp=CAU'),
      latlng: LatLng(36.398094, 127.349693),
      category: Categories.All,
      type: Types.Cadets,
      age: Ages.A_17_21,
      classes: Classes.Officer));
  lists.add(new School(
    idx: 6,
    name: "육군학생군사학교",
    address:"충청북도 괴산군 괴산읍 문무로 177",
    number:"+82438346043",
    web_address:"https://www.armyofficer.mil.kr:460/",
    image:Image.network('data:image/png;base64,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'),
    latlng: LatLng(36.821519, 127.805987),
    category: Categories.Army,
    type: Types.CadetCandidate,
    age: Ages.A_20_27,
    classes: Classes.Officer));

  return lists;
}
