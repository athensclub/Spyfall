import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/pages/pages.dart';

class PlaceCard extends StatelessWidget {
  final Place _data;
  final bool Function(String) _placeExists;
  final Function(Place) _setData;
  final Function _delete;

  PlaceCard(this._data, this._placeExists, this._setData, this._delete);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white12,
      shadowColor: Colors.black,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _data.name,
                  style: TextStyle(
                    color: Colors.orange[400],
                    fontSize: 24.0,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _data.roles
                      .map((role) => Text(
                            role,
                            style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 18.0,
                            ),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.orange,
                ),
                onPressed: () async {
                  var place = await Get.toNamed(
                    Pages.editSinglePlace,
                    arguments: {
                      'name': _data.name,
                      'roles': List.of(_data.roles),
                      'placeExists': _placeExists,
                    },
                  );
                  _setData(place);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.delete,
                  color: Colors.orange,
                ),
                onPressed: () {
                  SpyfallDialog.showAreYouSureDialog(
                    text: 'Are you sure you want to delete ${_data.name}?',
                    onConfirm: () {
                      Get.back();
                      _delete();
                    },
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
