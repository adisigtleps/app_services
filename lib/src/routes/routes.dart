import 'package:app_services/src/pages/movies_page.dart';
import 'package:flutter/material.dart';
import 'package:app_services/src/pages/login_page.dart';
import 'package:app_services/src/pages/splash_page.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder> {
    'splash' : (context) => SplashPage(),
    'login' : (context) => LoginPage(),
    'movies' : (context) => MoviesPage()
  };
}