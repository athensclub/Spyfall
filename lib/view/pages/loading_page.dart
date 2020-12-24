import 'package:flutter/material.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/data/player.dart';
import 'package:spyfall/view/pages/pages.dart';
import 'package:get/get.dart';
import '../app_bar.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    await Place.load();
    await Player.load();
    Get.offNamed(Pages.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Loading...',
      ),
      body: Center(
        child: Text(
          'Loading. Please wait...',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.0,
          ),
        ),
      ),
    );
  }
}
