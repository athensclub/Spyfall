import 'dart:collection';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/data/player.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/pages/pages.dart';
import 'package:spyfall/view/spy_guess_place.dart';

import '../SpyfallListView.dart';
import '../button.dart';

class VotePage extends StatefulWidget {
  @override
  _VotePageState createState() => _VotePageState();
}

class _VotePageState extends State<VotePage> {
  bool _shown;
  int _index;
  List<Place> _placesPool;
  List<String> _playerPool;
  String _selected;
  Place _place;
  Place _guessedPlace;
  String _spy;
  HashMap<String, int> _voteCount;

  @override
  void initState() {
    super.initState();
    _voteCount = HashMap();
    _shown = false;
    _placesPool = Get.arguments['placesPool'];
    _place = Get.arguments['place'];
    _spy = Get.arguments['spy'];
    _index = 0;
  }

  int get maxVoteCount {
    int val = 0;
    _voteCount.forEach((key, int value) {
      if (value > val) val = value;
    });
    return val;
  }

  void nextPlayer() {
    if (_index + 1 < Player.players.length) {
      setState(() {
        _index++;
        _shown = false;
      });
    } else {
      bool spyWin =
          _guessedPlace.name == _place.name || _voteCount[_spy] != maxVoteCount;
      bool memberWin = _voteCount[_spy] == maxVoteCount;
      if (spyWin && memberWin) {
        Get.offNamed(Pages.gameEnded, arguments: {
          'place': _place,
          'spy': _spy,
          'description':
              'Spy got voted the most, but they guessed the place correctly.',
          'winnerTitle': 'Draw',
        });
      } else if (spyWin) {
        Get.offNamed(Pages.gameEnded, arguments: {
          'place': _place,
          'spy': _spy,
          'description': 'Spy did not got voted the most.',
          'winnerTitle': 'Spy wins',
        });
      } else {
        Get.offNamed(Pages.gameEnded, arguments: {
          'place': _place,
          'spy': _spy,
          'description':
              'Spy got voted the most, and they did not guessed the place correctly.',
          'winnerTitle': 'Member wins',
        });
      }
    }
  }

  Widget voteSpy() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Vote',
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
          Expanded(
            child: SpyfallListView(
              itemCount: _playerPool.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: Colors.grey[850],
                  checkColor: Colors.orange,
                  title: Text(
                    _playerPool[index],
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 20.0,
                    ),
                  ),
                  value: _selected == _playerPool[index],
                  onChanged: (bool val) {
                    setState(() {
                      if (val)
                        _selected = _playerPool[index];
                      else
                        _selected = null;
                    });
                  },
                );
              },
            ),
          ),
          Center(
            child: SpyfallRoundedRectangleButton(
              text: 'OK',
              fontSize: 20.0,
              onPressed: () {
                if (_selected == null) {
                  SpyfallDialog.showInfoDialog(
                    title: 'Error',
                    text: 'Please select a player to vote before continue.',
                  );
                  return;
                }
                setState(() {
                  _voteCount.putIfAbsent(_selected, () => 0);
                  _voteCount[_selected]++;
                });
                nextPlayer();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget spyGuessPlace() {
    return SpyGuessPlace(
      playerName: Player.players[_index],
      placesPool: _placesPool,
      onPlaceChosen: (Place place) {
        setState(() {
          _guessedPlace = place;
          nextPlayer();
        });
      },
    );
  }

  Widget _onShow() {
    return _spy == Player.players[_index] ? spyGuessPlace() : voteSpy();
  }

  Widget _onHidden() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
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
            text: 'VOTE',
            fontSize: 20.0,
            onPressed: () {
              setState(() {
                _selected = null;
                _playerPool = List.of(Player.players
                    .where((element) => element != Player.players[_index]));
                _shown = true;
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Vote',
      ),
      body: _shown ? _onShow() : _onHidden(),
    );
  }
}
