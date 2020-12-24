import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/pages/pages.dart';

import '../SpyfallListView.dart';

class ChoosePlacesPage extends StatefulWidget {
  @override
  _ChoosePlacesPageState createState() => _ChoosePlacesPageState();
}

class _ChoosePlacesPageState extends State<ChoosePlacesPage> {
  List<Place> _data;
  HashSet<String> _selected;

  @override
  void initState() {
    super.initState();
    _data = List.of(Place.places.where((element) => element.roles.length > 0));
    _selected = HashSet.of(_data.map((e) => e.name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Choose Places',
        actionButtonText: 'PLAY',
        onActionButtonPressed: () {
          if (_selected.length < 2) {
            SpyfallDialog.showInfoDialog(
              title: 'Error',
              text: 'Please choose at least 2 places to continue.',
            );
            return;
          }
          Get.offAllNamed(Pages.viewRole, arguments: {
            'places': List.of(
                _data.where((element) => _selected.contains(element.name))),
          });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Center(
              child: Text(
                'Places',
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 24.0,
                ),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: SpyfallListView(
                itemCount: _data.length,
                itemBuilder: (BuildContext context, int index) {
                  return CheckboxListTile(
                    activeColor: Colors.grey[850],
                    checkColor: Colors.orange,
                    title: Text(
                      _data[index].name,
                      style: TextStyle(
                        color: Colors.grey[100],
                        fontSize: 20.0,
                      ),
                    ),
                    value: _selected.contains(_data[index].name),
                    onChanged: (bool val) {
                      setState(() {
                        if (val)
                          _selected.add(_data[index].name);
                        else
                          _selected.remove(_data[index].name);
                      });
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Note that a place with no roles can not be chosen.',
              style: TextStyle(
                color: Colors.grey[100],
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
