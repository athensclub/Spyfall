import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/data/player.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/button.dart';
import 'package:spyfall/view/pages/pages.dart';

class ViewRolePage extends StatefulWidget {
  @override
  _ViewRolePageState createState() => _ViewRolePageState();
}

/// The implementation randomize the place, then randomize the spy, then for the rest of players:
/// shuffle the roles and give to each of them, then when there are no roles left, reset the roles and shuffle it,
/// then give it to the remaining players. Repeat until every player is given a role.
class _ViewRolePageState extends State<ViewRolePage> {
  Random _random;
  List<Place> _placesPool;
  Place _place;
  List<String> _currentRoles;
  String _spy;
  int _index;
  String _currentUserRole;
  bool _shown;

  @override
  void initState() {
    super.initState();
    _shown = false;
    _random = Random();
    _placesPool = Get.arguments['places'];
    _place = _placesPool[_random.nextInt(_placesPool.length)];
    _currentRoles = List.of(_place.roles);
    _currentRoles.shuffle(_random);
    _spy = Player.players[_random.nextInt(Player.players.length)];
    _index = 0;
  }

  List<Widget> _onShow() {
    return [
      Center(
        child: Text(
          'Your Role',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 24.0,
          ),
        ),
      ),
      SizedBox(
        height: 12.0,
      ),
      Center(
        child: Text(
          Player.players[_index],
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 24.0,
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Row(
        children: [
          Text(
            'Place: ',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24.0,
            ),
          ),
          Text(
            _spy == Player.players[_index]
                ? 'You have to figure this out'
                : _place.name,
            style: TextStyle(
              color: Colors.grey[100],
              fontSize: 24.0,
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
            'Role: ',
            style: TextStyle(
              color: Colors.orange,
              fontSize: 24.0,
            ),
          ),
          Text(
            _spy == Player.players[_index] ? 'You Are SPY' : _currentUserRole,
            style: TextStyle(
              color: Colors.grey[100],
              fontSize: 24.0,
            ),
          ),
        ],
      ),
      SizedBox(
        height: 20.0,
      ),
      Center(
        child: SpyfallRoundedRectangleButton(
          text: 'OK',
          fontSize: 20.0,
          onPressed: () {
            if (_index + 1 < Player.players.length) {
              setState(() {
                _index++;
                _shown = false;
              });
            } else {
              Get.offNamed(Pages.timer, arguments: {
                'placesPool': _placesPool,
                'place': _place,
                'spy': _spy,
              });
            }
          },
        ),
      ),
    ];
  }

  List<Widget> _onHidden() {
    return [
      Center(
        child: Text(
          'Your Role',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 24.0,
          ),
        ),
      ),
      SizedBox(height: 20.0),
      Center(
        child: Text(
          'Pass this phone to',
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 18.0,
          ),
        ),
      ),
      SizedBox(
        height: 12.0,
      ),
      Center(
        child: Text(
          Player.players[_index],
          style: TextStyle(
            color: Colors.grey[100],
            fontSize: 24.0,
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      SpyfallRoundedRectangleButton(
        text: 'VIEW',
        fontSize: 20.0,
        onPressed: () {
          if (_spy != Player.players[_index]) {
            setState(() {
              if (_currentRoles.isEmpty) {
                _currentRoles = List.of(_place.roles);
                _currentRoles.shuffle(_random);
              }
              _currentUserRole = _currentRoles.removeLast();
            });
          }
          // separate set state because we want to make show = true, even if the player is spy.
          setState(() {
            _shown = true;
          });
        },
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(text: 'View Role'),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: _shown ? _onShow() : _onHidden(),
        ),
      ),
    );
  }
}
