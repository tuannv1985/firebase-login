import 'package:firebase_login_tuan2/core/router/route_name.dart';
import 'package:firebase_login_tuan2/presentation/pages/account_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/home_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/login_page.dart';
import 'package:firebase_login_tuan2/presentation/pages/signup_page.dart';
import 'package:firebase_login_tuan2/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class RouteApp{
  Route? onGenerateRoute(RouteSettings settings){
    switch (settings.name) {
      case RouteName.homescreen:
        return MaterialPageRoute(
            builder: (_) => HomeScreen());
        break;
      case RouteName.login:
        return MaterialPageRoute(
          builder: (_) => LoginPage());
        break;
      case RouteName.homepage:
        return MaterialPageRoute(
            builder: (_) => HomePage());
        break;
      case RouteName.register:
        return MaterialPageRoute(
            builder: (_) => SignUpPage());
        break;
      case RouteName.account:
        return MaterialPageRoute(
            builder: (_) => AccountPage());
        break;
      default:
        return null;
    }
  }
}