  import 'package:flutter/material.dart';
import 'package:timetracker/widgets/platform_alert_dialog.dart';
import 'package:provider/provider.dart';
import 'services/auth.dart';
class HomePage extends StatelessWidget {


  Future<void> _signOut(BuildContext context) async {
    try {
      final auth = Provider.of<AuthBase>(context,listen : false);
      await auth.signOut();
//      print('inside signout');
    } catch (e) {
      print(e);
    }
  }

  Future<void> _confirmSignOut(BuildContext context) async{
    final didRequestSignOut = await PlatformAlertDialog(
       title: 'Logout',
      content: 'Are you sure that you want to logout ? ',
      defaultActionText:  'Logout',
      cancelActionText: 'Cancel',
    ).show(context);
    if(didRequestSignOut == true ){
      _signOut(context);
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
            onPressed: () => _confirmSignOut(context),
          )
        ],
      ),
    );
  }
}
