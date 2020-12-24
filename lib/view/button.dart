import 'package:flutter/material.dart';

class SpyfallRoundedRectangleButton extends FlatButton {
  SpyfallRoundedRectangleButton(
      {String text, Function onPressed, double fontSize = 20.0})
      : super(
          onPressed: onPressed,
          color: Colors.black,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.grey[100],
              fontSize: fontSize,
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ),
        );
}
