import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timetracker/app/sign_in/sign_in_manager.dart';
import 'package:timetracker/app/sign_in/sign_in_button.dart';
import 'package:timetracker/app/sign_in/social_sign_in_button.dart';
import 'package:timetracker/services/auth.dart';
import 'email_sign_in_page.dart';
import 'package:flutter/services.dart';
import 'package:timetracker/widgets/platform_exception_alert_dialog.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({
    Key key,
    @required this.manager,
    @required this.isLoading,
  }) : super(key: key);

  final SignInManager manager;
  final bool isLoading;

  //------functions---------

  // Since this is a static method it doesnt need objects to access
  // hence it is accessed from the Landing page first without the objects
  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return ChangeNotifierProvider<ValueNotifier<bool>>(
      create: (_) => ValueNotifier<bool>(false),
      child: Consumer<ValueNotifier<bool>>(
        builder: (_, isLoading, __) =>
            Provider<SignInManager>(
              create: (_) => SignInManager(auth: auth, isLoading: isLoading),
              child: Consumer<SignInManager>(
                builder: (context, manager, _) =>
                    SignInPage(
                      manager: manager,
                      isLoading: isLoading.value,
                    ),
              ),
            ),
      ),
    );
  }

  // to display error when signed in
  void _showSignInError(BuildContext context, PlatformException exception) {
    PlatformExceptionAlertDialog(
      title: 'Sign in Failed',
      exception: exception,
    ).show(context);
  }

  // to sign in with google
  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await manager.signInWithGoogle();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  // to sign in with Facebook
  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await manager.signInWithFacebook();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  //email sign in with email
  // it will call to EmailSignInPage
  void _signInWithEmail(BuildContext context) {
    //to show the email sign in page
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true,
      builder: (context) => EmailSignInPage(),
    ));
  }

  // anonymous sign in
  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await manager.signInAnonymously();
    } on PlatformException catch (e) {
      if (e.code != 'ERROR_ABORTED_BY_USER') {
        _showSignInError(context, e);
      }
    }
  }

  // ----UI---------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity Tracker'),
        centerTitle: true,
        elevation: 25.0,
      ),
      body: _buildContent(context),
      backgroundColor: Colors.grey[200],
    );
  }

  // it builds the google facebook , email and sign anonymously buttons
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 50.0, child: _buildHeader()),
          SizedBox(
            height: 70.0,
          ),
          SocialSignInButton(
            assetName: 'images/google_logo.png',
            text: 'Sign in with Google',
            color: Colors.white,
            textColor: Colors.black87,
            onPressed: isLoading ? null : () => _signInWithGoogle(context),
          ),
          SizedBox(
            height: 15.0,
          ),
          SocialSignInButton(
            assetName: 'images/facebook_logo.png',
            text: 'Sign in with Facebook',
            color: Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: isLoading ? null : () => _signInWithFacebook(context),
          ),
          SizedBox(
            height: 15.0,
          ),
          SignInButton(
            text: 'Sign in with Email',
            color: Colors.teal[300],
            onPressed: () {
              _signInWithEmail(context);
            },
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
            onPressed: isLoading ? null : () => _signInAnonymously(context),
          ),
        ],
      ),
    );
  }

  // this is for making the loading button appear when one of the sign in button is clicked
  //it basically loads till user id is created and fetched from firebase
  Widget _buildHeader() {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Text(
      'Sign In',
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }
}
