enum Categories{
  Army, //육군
  Navy, //해군
  AirForce  //공군
}
enum Types{
  Cadets, //사관
  CadetCandidate, //사관생도
  Officer,  //전문사관
  Etc //기타
}
class Schools{
  int idx;
  var latlng;
  Categories catagory;
  Types type;

  Schools({int idx, var latlng, Categories category, Types type}){
    this.catagory = category;
    this.latlng = latlng;
    this.idx = idx;
    this.type = type;
  }

}