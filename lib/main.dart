import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'app/sign_in/sign_in_page.dart';

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
        home: SignInPage());
  }
}
