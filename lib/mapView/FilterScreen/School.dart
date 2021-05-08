enum Categories{
  Army, //육군
  Navy, //해군
  AirForce  //공군
}
enum Types{
  Cadets, //사관
  CadetCandidate, //사관후보생
  Officer,  //전문사관
  Etc //기타
}
enum Ages{
  A_17_21,
  A_19_25,
  A_25_28,
  A_28_31
}
enum Classes{
  Officer,  // 장교
  Sergeant, // 부사관
  Soldier   // 용사
}
const categoryMap = {
  "육군": Categories.Army,
  "공군": Categories.AirForce,
  "해군": Categories.Navy
};

const classMap = {
  "장교": Classes.Officer,
  "부사관": Classes.Sergeant,
  "용사": Classes.Soldier
};

const typeMap = {
  "사관생도": Types.Cadets,
  "사관후보생": Types.CadetCandidate,
  "전문사관": Types.Officer,
  "기타": Types.Etc
};

const ageMap = {
  '17세 이상 21세 미만': Ages.A_17_21,
  '19세 이상 25세 미만': Ages.A_19_25,
  '25세 이상 28세 미만': Ages.A_25_28,
  '28세 이상 31세 미만': Ages.A_28_31
};

class School{
  String name;
  int idx;
  var latlng;
  Categories catagory;
  Types type;
  Ages age;
  Classes classes;

  School({String name, int idx, var latlng, Categories category, Types type, Ages age, Classes classes}){
    this.name = name;
    this.idx = idx;
    this.catagory = category;
    this.latlng = latlng;
    this.type = type;
    this.age = age;
    this.classes = classes;
  }
}