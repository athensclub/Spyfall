import 'package:flutter/material.dart';

class SpyfallFloatingActionButtonAdd extends FloatingActionButton {
  SpyfallFloatingActionButtonAdd({onPressed})
      : super(
          backgroundColor: Colors.black38,
          onPressed: onPressed,
          child: Icon(
            Icons.add,
            color: Colors.grey[100],
          ),
        );
}
