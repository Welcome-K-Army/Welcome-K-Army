import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/routes.dart';
import 'views/opening_screen.dart';
import 'model/user_data_model.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/menu.dart';
import 'settings/profile_edit.dart';
import 'settings/profile_menu.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Opening View',
        routes: AppRoutes.define(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case MenuScreen.routeName:
              {
                return MaterialPageRoute(builder: (context) => MenuScreen(userData: settings.arguments));
              }
              break;
            case EditProfile.routeName:
              {
                return MaterialPageRoute(builder: (context) => EditProfile(userData: settings.arguments));
              }
              break;

            case Profile_menu.routeName:
              {
                return MaterialPageRoute(builder: (context) => Profile_menu(userData: settings.arguments));
              }
              break;

            default:
              {
                return MaterialPageRoute(builder: (context) => OpeningView());
              }
              break;
          }
        });
  }
}

// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'loginPage.dart';
// import 'joinOrLogin.dart';
// import 'Home.dart';
// import 'userDetail.dart';
// import '/lib/views/menu.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   FirebaseFirestore.instance;
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => UserDetail(),
//       child: MaterialApp(
//         home: Splash(),
//       ), //MaterialApp
//     );
//   }
// }

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<User>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.data == null) {
//             return ChangeNotifierProvider<JoinOrLogin>.value(value: JoinOrLogin(), child: LoginPage()); //ChangeNotifierProvider
//           } else {
//             final userDetail = Provider.of<UserDetail>(context);
//             userDetail.uId = snapshot.data.uid;
//             return MainPage(uId: snapshot.data.uid, email: snapshot.data.email);
//           }
//         }); //SteamBuilder
//   }
// }

// // 2021년 2월 23일 기준
// // Authresult -> UserCredential
// // FirebaseUser -> User

// // main.dart  파일 수정
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }

// // StreamBuilder 부분
// // stream: FirebaseAuth.instance.authStateChanges()
