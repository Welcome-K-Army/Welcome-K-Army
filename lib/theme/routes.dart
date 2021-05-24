import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/menu.dart';
import '../views/register_screen.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';
  String get routelogin=>authLogin;
  String get routeregister=>authRegister;
  String get routemenu=>menu;
  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => Login(),
      authRegister: (context) => Register(),
      menu: (context) => MenuScreen(),
    };
  }
}
