import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app/landing_page.dart';
import 'package:timetracker/services/auth.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Activity Tracker',
        theme: ThemeData(
        primarySwatch: Colors.indigo,
        ),
        home: LandingPage(
          auth: Auth(),
        ));
  }
}
