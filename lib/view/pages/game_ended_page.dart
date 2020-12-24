import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/pages/pages.dart';

class GameEndedPage extends StatefulWidget {
  @override
  _GameEndedPageState createState() => _GameEndedPageState();
}

class _GameEndedPageState extends State<GameEndedPage> {
  Place _place;
  String _spy;
  String _description;
  String _winnerTitle;

  @override
  void initState() {
    super.initState();
    _place = Get.arguments['place'];
    _spy = Get.arguments['spy'];
    _description = Get.arguments['description'];
    _winnerTitle = Get.arguments['winnerTitle'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Game Ended',
        actionButtonText: 'HOME',
        onActionButtonPressed: () {
          Get.offNamed(Pages.home);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Center(
              child: Text(
                _winnerTitle,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.orange,
                ),
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Center(
              child: Text(
                _description,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.grey[100],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Text(
                  'Place: ',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  _place.name,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[100],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 12.0,
            ),
            Row(
              children: [
                Text(
                  'Spy: ',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.orange,
                  ),
                ),
                Text(
                  _spy,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey[100],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
