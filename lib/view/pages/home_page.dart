import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/button.dart';
import 'package:spyfall/view/pages/pages.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Spyfall - By Kawin R.',
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('images/spyfall_icon.png'),
                  radius: 64.0,
                ),
              ),
            ),
            Expanded(
              child: IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SpyfallRoundedRectangleButton(
                      text: 'PLAY',
                      onPressed: () {
                        Get.toNamed(Pages.playerSettings);
                      },
                    ),
                    SpyfallRoundedRectangleButton(
                      text: 'EDIT PLACES',
                      onPressed: () {
                        Get.toNamed(Pages.editPlaces);
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
