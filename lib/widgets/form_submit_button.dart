import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timetracker/widgets/custom_raised_button.dart';




class FormSubmitButton extends CustomRaisedButton {



  FormSubmitButton({
    @required String text,
    @required VoidCallback onPressed,
  }) : super(
    child: Text(
      text,
      style: TextStyle(color: Colors.white,fontSize: 20.0),
    ),
    height:44.0,
    color:Colors.indigo,
    onPressed:onPressed,
  );
}
