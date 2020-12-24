import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/button.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/pages/pages.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  List<Place> _placesPool;
  Place _place;
  String _spy;
  Duration _duration;
  bool _started;
  int _secondsLeft;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _placesPool = Get.arguments['placesPool'];
    _place = Get.arguments['place'];
    _spy = Get.arguments['spy'];
    _duration = Duration(
      minutes: 5,
    );
    _started = false;
  }

  Widget hasNotStarted() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Questioning Time',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          GestureDetector(
            onTap: () async {
              SpyfallDialog.showPickTimeDialog(
                initialTimerDuration: _duration,
                onReceiveInput: (Duration dur) {
                  setState(() {
                    _duration = dur;
                  });
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  (_duration.inSeconds / 60).floor().toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 64.0,
                  ),
                ),
                Text(
                  ' : ',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 64.0,
                  ),
                ),
                Text(
                  (_duration.inSeconds % 60).floor().toString().padLeft(2, '0'),
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 64.0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Center(
            child: SpyfallRoundedRectangleButton(
              text: 'START',
              fontSize: 18.0,
              onPressed: () {
                setState(() {
                  _secondsLeft = _duration.inSeconds;
                  _started = true;
                  _timer = Timer.periodic(
                      Duration(
                        seconds: 1,
                      ), (timer) {
                    if (_secondsLeft == 0) {
                      _timer.cancel();
                      return;
                    }
                    setState(() {
                      _secondsLeft -= 1;
                    });
                  });
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget hasStarted() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text(
            'Questioning Time',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24.0,
            ),
          ),
          SizedBox(
            height: 100.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (_secondsLeft / 60).floor().toString().padLeft(2, '0'),
                style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 64.0,
                ),
              ),
              Text(
                ' : ',
                style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 64.0,
                ),
              ),
              Text(
                (_secondsLeft % 60).floor().toString().padLeft(2, '0'),
                style: TextStyle(
                  color: Colors.grey[100],
                  fontSize: 64.0,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 100.0,
          ),
          SpyfallRoundedRectangleButton(
            fontSize: 18.0,
            text: 'VOTE',
            onPressed: () {
              setState(() {
                _timer.cancel();
              });
              Get.offNamed(
                Pages.vote,
                arguments: {
                  'placesPool': _placesPool,
                  'place': _place,
                  'spy': _spy,
                },
              );
            },
          ),
          SizedBox(
            height: 20.0,
          ),
          SpyfallRoundedRectangleButton(
            fontSize: 18.0,
            text: 'SPY REVEALED',
            onPressed: () {
              setState(() {
                _timer.cancel();
              });
              Get.offNamed(
                Pages.spyRevealed,
                arguments: {
                  'placesPool': _placesPool,
                  'place': _place,
                  'spy': _spy,
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Spyfall - By Kawin R.',
      ),
      body: _started ? hasStarted() : hasNotStarted(),
    );
  }
}
