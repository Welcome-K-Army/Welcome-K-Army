import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final GlobalKey<FormState> _formkey =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final TextEditingController _emailController=TextEditingController();
    final TextEditingController _passwordController=TextEditingController();

    return MaterialApp(
      home: Scaffold(
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
                Container(
                  width: 200,
                  height: 200,
                  color: Colors.blue,
                ),
                Stack(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(12),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(16)
                        ),//RoundedRectangleBorder
                        elevation:6,
                        child: Padding(
                          padding: const EdgeInsets.only(left:12,right:12,top:12,bottom:32),
                          child:Form(
                            key: _formkey,
                            child:Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: <Widget>[
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    icon:Icon(Icons.account_circle),
                                    labelText:"Email",
                                  ),//InputDecoration
                                validator:(String value){
                                  if (value.isEmtpy){
                                    return "Please input correct Email";
                                  }
                                  return null;
                                },
                               ),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    icon:Icon(Icons.vpn_key),
                                    labelText:"Password",
                                  ),//InputDecoration
                                validator:(String value){
                                  if (value.isEmtpy){
                                    return "Please input correct Password";
                                  }
                                  return null;
                                },
                               ),//TextFormField
                                Text("Forgot Password"),
                              ],//<Widget>[]
                          )),//Column,Form
                      ),//Padding
                    ),//Card
                    Container(
                      width: 200,
                      height: 200,
                      color: Colors.black,
                    ),//Container 
                  ),//Padding
                ],), //<Widget>[], Stack
                Text("Don't Have an Account?"),
                Container(
                  height: 20,
                )
              ], //<Widget>[]
            ), //Column
          ], //<Widget>[]
        ), //Stack
      ), //Scaffold
    ); //MaterialApp
  }
}
