import 'dart:async';

import 'package:flutter/material.dart';
import 'package:app_services/src/shared/preferences.dart';

class SplashPage extends StatelessWidget {

  final preferences = Preferences();

  @override
  Widget build(BuildContext context) {

    changeScreen(context);

    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Container(
        padding: EdgeInsets.all(50.0),
        child: Center(
          child: Image(
            image: AssetImage('assets/img/squirtle.png')
          ),
        ),
      ),
    );
  }

  void changeScreen(BuildContext context) {

    final String routeName = preferences.token == '' ? 'login' : 'movies';

    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, routeName);
    });
  }
}