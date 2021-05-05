import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class ForgetPw extends StatefulWidget {
  @override
  _ForgetPwState createState() => _ForgetPwState();
}

class _ForgetPwState extends State<ForgetPw> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController(); //email 컨트롤러

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forget Password"),
      ),
      body: Form(
        key: _formkey,
        child :Column(
          children:<Widget>[
            TextFormField(
            //이메일
            controller: _emailController,
            decoration: InputDecoration(
              icon: Icon(Icons.account_circle),
              labelText: "Email",
            ), //InputDecoration
            validator: (String value) {
              if (value.isEmpty) {
                return "Please input correct Email!";
              }
              return null;
            }), //TextFormField 이메일
            FlatButton(onPressed: ()async{
              await FirebaseAuth.instance.sendPasswordResetEmail(email:_emailController.text);
              final snackBar = SnackBar(
              content: Text("Check your email for password reset."),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },child:Text("Reset Password"))
          ],
        ),
      ),
    );
  }

}