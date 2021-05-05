import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_plugins';
import 'joinOrLogin.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();//email 컨트롤러
  final TextEditingController _passwordController = TextEditingController();//password 컨트롤러
  
  @override
  Widget build(BuildContext context) {

    final Size size=MediaQuery.of(context).size;
    return 
    Scaffold(
        body: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
          //상단 이미지 부
                _LogoImage,
          //로그인 부
                Stack(
                  children: <Widget>[
                    _inputForm(size),
                    _buttonLogin(size),
                  ],//<Widget>
                ), //, Stack
          //하단 회원가입 연결 부
                Container(
                  height: size.height*0.1,
                ),
                Consumer<JoinOrLogin>(
                  builder:(BuildContext context, JoinOrLogin joinOrLogin, Widget child)=>
                    GestureDetector(
                    onTap: (){
                      joinOrLogin.toggle();
                    },
                    child:Text(joinOrLogin.isJoin?"Already have an Account?":"Don't you have an Account?",
                    style: TextStyle(color:joinOrLogin.isJoin?Colors.red:Colors.green,))
                  ),
                ),
                Container(
                  height: size.height*0.05,
                ),
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ); //Scaffold
  }


  //로그인 폼
  Widget _inputForm(Size size){
    return  Padding(
      padding: EdgeInsets.all(size.width*0.05),
      child:Card(
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.circular(16)
        ),
        elevation:6,
        child:Padding(
          padding: EdgeInsets.only(left:12,right:12,top:12,bottom:32 ),
          child:Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: <Widget>[
              TextFormField(//이메일
                controller: _emailController,
                decoration: InputDecoration(icon:Icon(Icons.account_circle),
                labelText:"Email",
                ),//InputDecoration
                validator: (String value){
                  if (value.isEmpty){
                    return "Please input correct Email!";
                  }
                  return null;
                }
              ),//TextFormField 이메일

              TextFormField(//패스워드
                obscureText:true,
                controller: _passwordController,
                decoration: InputDecoration(icon:Icon(Icons.vpn_key),
                labelText:"Password",
                ),//InputDecoration
                validator: (String value){
                  if (value.isEmpty){
                    return "Please input correct Password!";
                  }
                  return null;
                }
              ),//TextFormField 패스워드
              Container(
                height:10,
              ),
              Consumer<JoinOrLogin>(
                builder: (context,value,child)=>Opacity(
                    opacity:value.isJoin ?0:1,
                    child:Text("Forgot Password")),
                ),
              ]//Widget
            )//Column
          ),//Form
        ),//Padding
      ),//Card
    );//Padding
  }

  //로그인 버튼
  Widget _buttonLogin(Size size) => Positioned(
    left: size.width*0.15,
    right:size.width*0.15,
    bottom:0,
    child:SizedBox(
      height:50,
      child:Consumer<JoinOrLogin>(
        builder:(context,joinOrLogin,child)=>RaisedButton(
            child: Text(joinOrLogin.isJoin?"Sign Up":"Sign In", style:TextStyle(fontSize:20,color:Colors.white),),
            color: joinOrLogin.isJoin?Colors.red:Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius:BorderRadius.circular(15)
            ),
            onPressed:(){
              if(_formkey.currentState.validate()){
                joinOrLogin.isJoin?_register(context):_login(context);
              }
            }
          ),//RaisedButton
      ),
    ),//SizedBox
  );//Positioned



//상단부 이미지
  Widget get _LogoImage => Expanded(
    child:Padding(
      padding: const EdgeInsets.only(top: 40, left: 24, right: 24),
      child: FittedBox(
        fit: BoxFit.contain,
        child:CircleAvatar(
          backgroundImage : NetworkImage("https://previews.123rf.com/images/phanuchat/phanuchat1604/phanuchat160400014/55601666-%EA%B5%B0%EC%82%AC-%EB%82%A8%EC%84%B1%EA%B3%BC-%EC%97%AC%EC%84%B1-%ED%9D%B0%EC%83%89-%EB%B0%B0%EA%B2%BD-%EA%B7%80%EC%97%AC%EC%9A%B4-%ED%94%8C%EB%9E%AB-%EB%A7%8C%ED%99%94-%EC%8A%A4%ED%83%80%EC%9D%BC-%EA%B2%A9%EB%A6%AC-%EB%90%9C-%EB%B2%A1%ED%84%B0-%EC%9D%BC%EB%9F%AC%EC%8A%A4%ED%8A%B8-%EB%A0%88%EC%9D%B4-%EC%85%98%EC%97%90-%EA%B3%A0%EB%A6%BD-%EB%90%9C-%ED%8F%89%EB%A9%B4-%EB%A7%8C%ED%99%94-%EC%BA%90%EB%A6%AD%ED%84%B0-%EB%94%94%EC%9E%90%EC%9D%B8%EC%97%90-%EC%9C%84%EC%9E%A5-%EC%A0%9C%EB%B3%B5%EC%9D%84-%EC%9E%85%EC%9D%80-%EA%B5%B0%EC%9D%B8.jpg"),
        ),//CircleAvatar
      ),//FittedBox
    ),//Padding
  );//Expanded
  // FadeInImage.assetNetwork(
  //   placeholder:"image/Loading.gif",
  //   image: "https://lh3.googleusercontent.com/proxy/w1P2JMIYg4J5bSkZ594flSX5dvIxDkQ9rO8dgcGNzgOPxkOkJACiHXplqzmrVX584Uqnr6QX0IVqWK83DaB4LMsxzGNm_c8nKublP_uKmxgqmSPS9QZzs8z8-30uHa1i",
  // ),

  // 로그인 메서드
  void _login(BuildContext context) async{
    final UserCredential result =await FirebaseAuth.instance.signInWithEmailAndPassword(email:_emailController.text,password:_passwordController.text);
    final User user = result.user;

    if(user==null){
      final snackBar = SnackBar(content : Text("Please try again later."),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  // 계정생성 메서드
  void _register(BuildContext context) async{
    final UserCredential result =await FirebaseAuth.instance.createUserWithEmailAndPassword(email:_emailController.text,password:_passwordController.text);
    final User user = result.user;

    if(user==null){
      final snackBar = SnackBar(content : Text("Please try again later."),);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    //스트림 빌더 안쓸경우 화면 전환 하는 방법
    //Navigator.push(context, MaterialPageRoute(builder:(context)=>MainPage(email:user.email));
    
  }
}