//import 'dart:io';
//import 'dart:core';
import 'package:flutter/material.dart';
import 'package:myfarm/screens/add_production_page.dart';
import 'package:myfarm/screens/home_page.dart';
import 'package:myfarm/screens/login_page.dart';

class RouteGenerator {
  static const String homePage = '/';
  static const String loginPage = "/loginpage";
  static const String addProdPage = "/addproduction";

  RouteGenerator._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homePage:
        return MaterialPageRoute(
            builder: (_) => const MyHomePage(title: 'مزرعتي'));
      case addProdPage:
        return MaterialPageRoute(builder: (_) => AddProduction());
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
