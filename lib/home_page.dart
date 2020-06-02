  import 'package:flutter/material.dart';
import 'services/auth.dart';

class HomePage extends StatelessWidget {
  HomePage({@required this.auth});

  final AuthBase auth;

  Future<void> _signOut() async {
    try {
      await auth.signOut();
//      print('inside signout');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home page'),
        centerTitle: true,
        actions: <Widget>[
          FlatButton(
            child: Text(
              'Logout',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: _signOut,
          )
        ],
      ),
    );
  }
}
