import 'package:flutter/material.dart';

class SpyfallAppBar extends AppBar {
  SpyfallAppBar(
      {String text, String actionButtonText, Function onActionButtonPressed})
      : super(
          backgroundColor: Colors.grey[850],
          title: Text(
            text,
            style: TextStyle(
              color: Colors.grey[100],
            ),
          ),
          actions: actionButtonText == null
              ? []
              : [
                  Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: TextButton(
                      style: TextButton.styleFrom(primary: Colors.white),
                      child: Text(actionButtonText),
                      onPressed: onActionButtonPressed,
                    ),
                  ),
                ],
        );
}
