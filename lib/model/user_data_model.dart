class UserData {
  final String uid;
  final String nickName;
  final String email;
  final int age;
  final String creationDate;
  final String gender;
  

  const UserData ({
    this.uid,
    this.nickName,
    this.email,
    this.creationDate,
    this.gender,
    this.age,
  });

  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      uid: json['UID'].toString(),
      nickName: json['NickName'].toString(),
      email:json['Email'].toString(),
      age: json['Age'] as int,
      gender:json['Gender'].toString(),
      creationDate: json['CreationDate'].toString(),
    );
  }
}