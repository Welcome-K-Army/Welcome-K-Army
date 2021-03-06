
import 'dart:async';

import 'package:Army/provider/pdf_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:Army/constants.dart';
import 'package:Army/model/user.dart';
import 'package:Army/services/firebaseUtil.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Army/provider/event_provider.dart';
import 'package:Army/provider/noticeProvider.dart';
import 'package:Army/page/error/initialize_error_page.dart';
import 'package:Army/page/onboarding_page.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {

  runApp(
      MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => EventProvider()),
            ChangeNotifierProvider(create: (context) => NoticeProvider()),
            ChangeNotifierProvider(create: (context) => PdfProvider()),
          ],
          child:MyApp()
      )
  );
}

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

  @override
  Widget build(BuildContext context) {


    // Show error message if initialization failed
    if (_error) {
      return InitializeErrorPage();
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

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
      child: MaterialApp(
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            // ... app-specific localization delegate[s] here
            SfGlobalLocalizations.delegate
          ],
          supportedLocales: [
            const Locale('ko')
            // ... other locales the app supports
          ],
          locale: const Locale('ko'),
          theme: ThemeData(
              accentColor: Color(COLOR_PRIMARY),
            bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.black.withOpacity(0)),
          ),
          debugShowCheckedModeBanner: false,
          color: Color(COLOR_PRIMARY),
          home: OnBoarding()
      )
    );
  }

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
    if (auth.FirebaseAuth.instance.currentUser != null && currentUser != null) {
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


