import 'package:flutter/material.dart';

class CustomRaisedButton extends StatelessWidget {
  CustomRaisedButton({
    this.child,
    this.color,
    this.height: 50,
    this.textColor,
    this.onPressed,
    this.borderRadius: 4,
  });

  final double height;
  final Widget child;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RaisedButton(
        child: child,
        onPressed: onPressed,
        color: color,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius))),
      ),
    );
  }
}
