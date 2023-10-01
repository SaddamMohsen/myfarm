//import 'dart:io';
//import 'dart:core';
import 'package:flutter/material.dart';
import 'package:myfarm/features/production/presentation/add_production_page.dart';
import 'package:myfarm/screens/home_page.dart';
import 'package:myfarm/features/authentication/presentation/login_page.dart';
import 'package:myfarm/screens/splash_screen.dart';

class RouteGenerator {
  static const String homePage = '/homepage';
  static const String loginPage = '/loginpage';
  static const String splashPage = "/";
  static const String addProdPage = "/addproduction";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print(settings.name);
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreenAnim());
      case homePage:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const MyHomePage(title: 'مزرعتي'));
      case addProdPage:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                AddProduction(prodDate: DateTime.now()));
      case loginPage:
        return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        throw FormatException("Route not found");
    }
  }
}

class RouteException implements Exception {
  final String message;
  const RouteException(this.message);
}
