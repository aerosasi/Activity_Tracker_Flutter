import 'package:flutter/material.dart';
import 'package:timetracker/widgets/custom_raised_button.dart';

class SocialSignInButton extends CustomRaisedButton {
  SocialSignInButton({
   @required String assetName,
  @required String text,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  }) : assert(text!=null),
        assert(assetName!=null),
        super(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image.asset(
                assetName,
                height: 30,
                width: 40,
              ),
              Text(
                text,
                style: TextStyle(color: textColor),
              ),
              Opacity(
                opacity: 0,
                child: Image.asset(
                  assetName,
                  height: 30,
                  width: 40,
                ),
              )
            ],
          ),
          color: color,
          onPressed: onPressed,
        );
}
