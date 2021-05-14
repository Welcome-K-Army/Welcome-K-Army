import 'dart:io'; //카메라 접근하기 위해 필요한 라이블럷ㄹ
import 'package:image_picker/image_picker.dart';//갤러리 접근
import 'package:flutter/material.dart';
import '../model/user_data_model.dart';



class EditProfile extends StatefulWidget {
  final String currentOnlinUserId;

  EditProfile({this.currentOnlinUserId});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {

   TextEditingController profileNameTextEditingController = TextEditingController();
   TextEditingController emailTextEditingController = TextEditingController();
   TextEditingController password1TextEditingController = TextEditingController();
   TextEditingController password2TextEditingController = TextEditingController();
  
  final _scaffoldGlobalKey = GlobalKey<ScaffoldState>();

  UserData user;

  PickedFile _imageFile;
  final ImagePicker _picker=ImagePicker();

  bool isObscurePassword=true; 

  //bool loading //비동기이용하기 위한 bool값

  // updateUserData(){
  //   setState((){
  //     //profilename,email.. 확인하는 로직 넣어주기
  //   })
  // }

  //초기값 가져오기
  @override
  void initState(){
    super.initState();

   // getUserinformation();
  }
  
  getUserinformation() async{
    setState((){
      loading=true;
    })
  }

  //DocumentSnapshot documentSnapshot이용해서  사용자 db가져오기
  //user=User.fromDocument(documentSnapshot);

  //profile,email등 입력한에 사용자 정보로 채워넣기
  //profileNameTextEditingController.text = user.profileName;
  //emailTextEditingController.text = user.email;
  //password1TextEditingController.text = user.password1;
  //password2TextEditingController.text = user.password2;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldGlobalKey 
      appBar: AppBar(
        title:Text('Register Profile'),
        backgroundColor: Colors.green,
        ),//AppBar

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

              
              buildTextField("username","minseok",false),
              buildTextField("Password","a123456",true),
              buildTextField("Email","sinminseok12@naver.com",false),
              buildTextField("Age","22",false),
              SizedBox(height:25,),

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
  
  
  Widget buildTextField(String labelText,String placeholder,bool isPasswordTextField){
    return Padding(
      padding:EdgeInsets.only(bottom:30),
      child:TextFormField( //key값 받으려면 TextField말고 TextFormField사용
      
        obscureText : isPasswordTextField ? isObscurePassword : false,
        decoration:InputDecoration(
          suffixIcon: isPasswordTextField ?
          IconButton(
            icon:Icon(Icons.remove_red_eye,color:Colors.grey),
            onPressed:(){}
          ): null,
        //contextPadding: EdgeInsets.only(bottom:5),
          labelText:labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText:placeholder,
          hintStyle:TextStyle(
            fontSize:16,
            fontWeight: FontWeight.bold,
            color:Colors.grey
          ),
        ),//InputDecoration
      ),//TextField
    );//Padding
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
    
}

// createProfileNameTextField(){
//   return Column(
//     corssAxisAlignment:CrossAxisAlignment.start,
//     children:[
//       Padding(
//         padding:EdgeInsets.only(top:13),
//         child:Text('Profile name',TextStyle(color:Colors.grey),),
//       ),
//       TextField()
//     ]
//   )
// }
