import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/floating_action_button.dart';
import 'package:spyfall/view/place_card.dart';

class EditPlacesPage extends StatefulWidget {
  @override
  _EditPlacesPageState createState() => _EditPlacesPageState();
}

class _EditPlacesPageState extends State<EditPlacesPage> {
  List<Place> _data = List<Place>();

  bool placeExists(String str) {
    return _data.any((p) => p.name == str);
  }

  @override
  void initState() {
    super.initState();
    // Take data from global, let the user edit this local data, then push this data back to global when the user is finished,
    _data.clear();
    _data.addAll(Place.places);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Edit Places',
        actionButtonText: 'RESET',
        onActionButtonPressed: () {
          SpyfallDialog.showAreYouSureDialog(
              text:
                  'Are you sure you want to reset the places data to original settings?',
              onConfirm: () {
                setState(() {
                  _data.clear();
                  _data.addAll(Place.defaultPlaces);
                });
                Get.back();
              });
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          Place.places.clear();
          Place.places.addAll(_data);
          Place.save();
          Get.back();
          return false;
        },
        child: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return PlaceCard(
              _data[index],
              placeExists,
              (place) => setState(() {
                _data[index] = place;
              }),
              () => setState(() {
                _data.removeAt(index);
              }),
            );
          },
        ),
      ),
      floatingActionButton: SpyfallFloatingActionButtonAdd(
        onPressed: () {
          SpyfallDialog.showInputDialog(
            labelText: 'Add Place',
            hintText: 'Enter place name here.',
            onReceiveInput: (String str) {
              if (str.isNotEmpty) {
                if (placeExists(str)) {
                  SpyfallDialog.showInfoDialog(
                    title: 'Error',
                    text: 'Place with name "$str" already exists!',
                  );
                } else {
                  setState(() {
                    _data.add(Place(name: str, roles: []));
                  });
                }
              }
            },
          );
        },
      ),
    );
  }
}
