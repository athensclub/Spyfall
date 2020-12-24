import 'package:flutter/material.dart';
import 'package:spyfall/data/place.dart';

import 'SpyfallListView.dart';
import 'button.dart';
import 'dialog.dart';

class SpyGuessPlace extends StatefulWidget {
  final List<Place> placesPool;
  final Function(Place) onPlaceChosen;
  final String playerName;

  SpyGuessPlace({this.placesPool, this.onPlaceChosen, this.playerName});

  @override
  _SpyGuessPlaceState createState() => _SpyGuessPlaceState();
}

class _SpyGuessPlaceState extends State<SpyGuessPlace> {
  Place _selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Center(
            child: Text(
              'Spy Guess Place',
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
              widget.playerName,
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
              itemCount: widget.placesPool.length,
              itemBuilder: (BuildContext context, int index) {
                return CheckboxListTile(
                  activeColor: Colors.grey[850],
                  checkColor: Colors.orange,
                  title: Text(
                    widget.placesPool[index].name,
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: 20.0,
                    ),
                  ),
                  value: _selected == null ? false : _selected.name == widget.placesPool[index].name,
                  onChanged: (bool val) {
                    setState(() {
                      if (val)
                        _selected = widget.placesPool[index];
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
                    text: 'Please select a place before continue.',
                  );
                  return;
                }
                widget.onPlaceChosen(_selected);
              },
            ),
          ),
        ],
      ),
    );
  }
}
