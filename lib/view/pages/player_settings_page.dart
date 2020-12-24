import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/player.dart';
import 'package:spyfall/view/SpyfallListView.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/floating_action_button.dart';
import 'package:spyfall/view/pages/pages.dart';

import '../app_bar.dart';

class PlayerSettingsPage extends StatefulWidget {
  @override
  _PlayerSettingsPageState createState() => _PlayerSettingsPageState();
}

class _PlayerSettingsPageState extends State<PlayerSettingsPage> {
  List<String> _data;

  @override
  void initState() {
    super.initState();
    _data = List.of(Player.players);
  }

  void _saveToGlobalAndFile() {
    Player.players.clear();
    Player.players.addAll(_data);
    Player.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Player Settings',
        actionButtonText: 'NEXT',
        onActionButtonPressed: () {
          if (_data.length < 3) {
            SpyfallDialog.showInfoDialog(
              title: 'Error',
              text: 'Please have at least 3 players to continue.',
            );
            return;
          }
          _saveToGlobalAndFile();
          Get.toNamed(Pages.choosePlaces);
        },
      ),
      body: WillPopScope(
        onWillPop: () async {
          _saveToGlobalAndFile();
          Get.back();
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Players',
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
                    return Row(
                      children: [
                        Expanded(
                          child: Text(
                            _data[index],
                            style: TextStyle(
                              color: Colors.grey[100],
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Colors.orange,
                          ),
                          onPressed: () {
                            SpyfallDialog.showAreYouSureDialog(
                              text:
                                  'Are you sure you want to remove the player "${_data[index]}"?',
                              onConfirm: () {
                                setState(() {
                                  _data.removeAt(index);
                                });
                                Get.back();
                              },
                            );
                          },
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpyfallFloatingActionButtonAdd(
        onPressed: () {
          SpyfallDialog.showInputDialog(
            labelText: 'Add Player',
            hintText: 'Enter player name here.',
            onReceiveInput: (String str) {
              if (str.isNotEmpty) {
                if (_data.contains(str)) {
                  SpyfallDialog.showInfoDialog(
                      title: 'Error',
                      text: 'A player with the name "$str" already exists!');
                } else {
                  setState(() {
                    _data.add(str);
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
