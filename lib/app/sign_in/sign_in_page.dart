import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/app/sign_in/sign_in_button.dart';
import 'package:timetracker/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracker'),
        centerTitle: true,
        elevation: 25.0,
      ),
      body: BuildContent(),
      backgroundColor: Colors.grey[200],
    );
  }
}

class BuildContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 30.0, color: Colors.black,fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 70.0,
          ),
          SocialSignInButton(
            assetName: 'images/google_logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: () {},
          ),
          SizedBox(
            height: 15.0,
          ),

          SocialSignInButton(
            assetName: 'images/facebook_logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () {},
          ),SizedBox(
            height: 15.0,
          ),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[300],
            onPressed: () {},
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            'or',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.0,
              color: Colors.black87,
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          SignInButton(
            text: 'Sign in Annonymously',
            color: Colors.yellow[300],
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
