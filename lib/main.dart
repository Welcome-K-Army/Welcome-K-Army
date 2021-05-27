// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'theme/routes.dart';
import 'views/opening_screen.dart';
// import 'model/user_data_model.dart';
import 'views/login_screen.dart';
import 'views/register_screen.dart';
import 'views/menu.dart';
import 'settings/profile_edit.dart';
import 'settings/profile_menu.dart';


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Army/constants.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/authenticate.dart';
import 'package:Army/services/helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'Opening View',
//         routes: AppRoutes.define(),
//         onGenerateRoute: (settings) {
//           switch (settings.name) {
//             case MenuScreen.routeName:
//               {
//                 return MaterialPageRoute(builder: (context) => MenuScreen(userData: settings.arguments));
//               }
//               break;
//             case Profile_menu.routeName:
//               {
//                 return MaterialPageRoute(builder: (context) => Profile_menu(userData: settings.arguments));
//               }
//               break;
//             case EditProfile.routeName:
//               {
//                 return MaterialPageRoute(builder: (context) => EditProfile(userData: settings.arguments));
//               }
//               break;

//             default:
//               {
//                 return MaterialPageRoute(builder: (context) => OpeningView());
//               }
//               break;
//           }
//         });
//   }
// }


class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static User currentUser;
  StreamSubscription tokenStream;

  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Show error message if initialization failed
    if (_error) {
      return MaterialApp(
          home: Scaffold(
        body: Container(
          color: Colors.white,
          child: Center(
              child: Column(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 25,
              ),
              SizedBox(height: 16),
              Text(
                'Failed to initialise firebase!',
                style: TextStyle(color: Colors.red, fontSize: 25),
              ),
            ],
          )),
        ),
      ));
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return MaterialApp(
        theme: ThemeData(accentColor: Color(COLOR_PRIMARY)),
        debugShowCheckedModeBanner: false,
        color: Color(COLOR_PRIMARY),
        home: OnBoarding());
  }

  @override
  void initState() {
    initializeFlutterFire();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (FirebaseAuth.instance.currentUser != null && currentUser != null) {
      if (state == AppLifecycleState.paused) {
        //user offline
        tokenStream.pause();
        currentUser.active = false;
        currentUser.lastOnlineTimestamp = Timestamp.now();
        FireStoreUtils.updateCurrentUser(currentUser);
      } else if (state == AppLifecycleState.resumed) {
        //user online
        tokenStream.resume();
        currentUser.active = true;
        FireStoreUtils.updateCurrentUser(currentUser);
      }
    }
  }
}

class OnBoarding extends StatefulWidget {
  @override
  State createState() {
    return OnBoardingState();
  }
}

class OnBoardingState extends State<OnBoarding> {
  Future hasFinishedOnBoarding() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool finishedOnBoarding = (prefs.getBool(FINISHED_ON_BOARDING) ?? false);

    if (finishedOnBoarding) {
      User firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        User user = await FireStoreUtils().getCurrentUser(firebaseUser.uid);
        if (user != null) {
          MyAppState.currentUser = user;
          pushReplacement(context, new OpeningView(/*user: user*/));
        } else {
          pushReplacement(context, new Login());
        }
      } else {
        pushReplacement(context, new Login());
      }
    } else {
      // pushReplacement(context, new OnBoardingScreen());
    }
  }

  @override
  void initState() {
    super.initState();
    hasFinishedOnBoarding();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(COLOR_PRIMARY),
      body: Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.white,
        ),
      ),
    );
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

// // main.dart  파일 수정
// // void main() async{
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }

// // StreamBuilder 부분
// // stream: FirebaseAuth.instance.authStateChanges()
