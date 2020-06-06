import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:timetracker/services/auth.dart';

// This is a bloc (Business Logic class )
// This is acts as bloc b/w Sign in page and auth.dart(which is a repository) , and firebase is data provider
// sign in page => sign in manager => auth.dart
class SignInManager {
  SignInManager({@required this.auth,@required this.isLoading});

  final AuthBase auth;
  final ValueNotifier<bool> isLoading;


  // to simplify calls in gooogle , fb and annoymously
 Future<User>_signIn(Future<User> Function() signInMethod)async{
   try {
      isLoading.value=true;
     return await signInMethod();
   } catch (e) {
     isLoading.value=false;
     rethrow;
   }

 }

  Future<User> signInAnonymously() async => await _signIn(auth.signInAnonymously);

  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);

  Future<User> signInWithFacebook() async => await _signIn(auth.signInWithFacebook);

}
