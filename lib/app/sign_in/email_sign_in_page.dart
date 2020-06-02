import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/email_sign_in_form.dart';
import 'package:timetracker/services/auth.dart';

class EmailSignInPage extends StatelessWidget {
  EmailSignInPage({@required this.auth});

  final AuthBase auth;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracker'),
        centerTitle: true,
        elevation: 25.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Card(
            child: EmailSignInForm(auth: auth,),
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

