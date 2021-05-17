import 'dart:io'; //카메라 접근하기 위해 필요한 라이블럷ㄹ
import 'package:image_picker/image_picker.dart';//갤러리 접근
import 'package:flutter/material.dart';


import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_data_model.dart';
import 'package:provider/src/provider.dart';




class EditProfile extends StatefulWidget {

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

  // final userData=Provider.of<UserDetail>(context);



  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController genderTextEditingController = TextEditingController();
  TextEditingController profileNameTextEditingController = TextEditingController();

    final usernicknameForm = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text('Profile Name', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          // controller: profileNameTextEditingController,
          decoration: InputDecoration(
            // hintText: '${user.nickName}',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            hintStyle: TextStyle(color: Colors.grey),

          ),
        )
      ],
    );

  
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  PickedFile _imageFile;
  final ImagePicker _picker=ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldGlobalKey,

      body:Container(
        padding:EdgeInsets.only(left:15,top:20,right:15),
        child:GestureDetector(
          onTap:(){
            FocusScope.of(context).unfocus();
          },
          child:ListView(
            children:[
              imageProfile(),
              SizedBox(height:30,),

              
              usernicknameForm,
              createProfileemailTextField(),
              createProfileGenderTextField(),

              createProfileAgeTextFormField(),
              SizedBox(height:40,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:[
                  OutlinedButton(
                    onPressed:(){},
                    child:Text("Cancel",style:TextStyle(
                      fontSize:17,
                      letterSpacing:2,
                      color:Colors.black,
                    )),//Text
                    style:OutlinedButton.styleFrom(
                      padding:EdgeInsets.symmetric(horizontal: 50),
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  ),//OutlineButton

                  ElevatedButton(
                  
                    onPressed:(){}, //바뀐 데이터 db로 보내는 함수 만들어야댐 updateUserData
                    child:Text("Save",style:TextStyle(
                      fontSize:17,
                      letterSpacing:2,
                      color:Colors.white,
                    )),
                    style:ElevatedButton.styleFrom(
                      primary:Colors.green,
                      padding:EdgeInsets.symmetric(horizontal: 50),
                      shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))
                    ),
                  )//ElevatedButton

                ]
              ),
            ],
          )//ListView
        ),
      ),//Container
    );//Scafolld
  }//


  Widget imageProfile(){
    return Center(
            child:Stack(
              children:[
                Container(
                  width:130,
                  height:130,
                  decoration: BoxDecoration(
                    border:Border.all(width:4,color:Colors.green),
                    boxShadow:[
                      BoxShadow(
                        spreadRadius:2,
                        blurRadius:10,
                        color:Colors.black.withOpacity(0.1)
                      ),//BoxShadow
                    ],
                    shape:BoxShape.circle,

                    image:DecorationImage( //DB에서 사진가져와야댐
                      fit:BoxFit.cover, //원본크기 유지
                      //CachedNetworkImageProvider(user.url),이용
                      image:NetworkImage('https://cdn.pixabay.com/photo/2015/11/26/00/14/woman-1063100_960_720.jpg')
                    )
                        

                  ),//BoxDecoration
                ),//Container

                Positioned( //프로필 수정ui
                  bottom:0,
                  right:0,

                  child:InkWell(
                    onTap:(){
                      showModalBottomSheet(context:context, builder:((builder)=>bottomSheet()));
                    },
                    child:Container(
                      height:40,
                      width:40,
                      decoration: BoxDecoration(
                        shape:BoxShape.circle,
                        color:Colors.green,
                      ),
                      child:Icon(Icons.edit,size:30,color: Colors.white ),
                    ),

                  ),

                ),//Positioned
              ],
            ),//Stack
         );//Center 
  }
  

  Widget bottomSheet(){
    return Container(
      height:100,
      width:MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal:20,
        vertical:20
      ),
      child: Column(
        children:<Widget>[
          Text(
            'Choose Profile photo',
            style:TextStyle(
              fontSize:20,
            ),
          ),//Text
          SizedBox(height: 20, ),
          Row(
            mainAxisAlignment : MainAxisAlignment.spaceBetween,
            children:<Widget>[
              FlatButton.icon(
                icon:Icon(Icons.camera,size:50,),
                onPressed:(){
                  takePhoto(ImageSource.camera);
                },
                label:Text('Camera',style:TextStyle(fontSize: 20, ),),
              ),
              FlatButton.icon(
                icon:Icon(Icons.photo_library,size:50,),
                onPressed:(){
                  takePhoto(ImageSource.gallery);
                },
                label:Text('Gallery',style:TextStyle(fontSize: 20, ),),
              ),
              
            ],//children
          )
        ],
      )//column

    );//container
  }//bottomSheet

    Future takePhoto(ImageSource source) async {
      final pickedFile = await _picker.getImage(source: source);

      setState(() {
        if (pickedFile != null) {
          _imageFile = pickedFile;
        } else {
          print('No image selected.');
        }
      });
    }
    


  createProfileemailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text('Email', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: emailTextEditingController,
          decoration: InputDecoration(
            // hintText: '${user.email}',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            hintStyle: TextStyle(color: Colors.grey),

          ),
        )
      ],
    );
  } //createProfileemailTextField
  createProfileGenderTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text('Gender', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: genderTextEditingController,
          decoration: InputDecoration(
            // hintText: '${user.gender}',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            hintStyle: TextStyle(color: Colors.grey),

          ),
        )
      ],
    );
  } //createProfileNameTextFormField
  createProfileAgeTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 13),
          child: Text('Age', style: TextStyle(color: Colors.grey),),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: ageTextEditingController,
          decoration: InputDecoration(
            // hintText: '${user.age}',
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            hintStyle: TextStyle(color: Colors.grey),

          ),
        )
      ],
    );
  } //createProfileNameTextFormField
}

