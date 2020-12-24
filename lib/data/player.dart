import 'dart:convert';
import 'dart:io';

import 'package:spyfall/view/dialog.dart';

import '../file_util.dart';

class Player{
  static final List<String> players = [];

  static Future<File> get _placesFile async {
    return File('${await FileUtils.localPath}/players.json');
  }

  /// save the current place data into local path file (players.json)
  static void save() async {
    try {
      final File file = await _placesFile;
      file.writeAsString(jsonEncode(players));
    } catch (e) {
      SpyfallDialog.showInfoDialog(title: 'Error', text: e.toString());
    }
  }

  /// Load the players data from local path file (players.json).
  /// Should be called only once when the app starts. The loaded data will go into this
  /// class' static instance 'players'
  static Future<void> load() async {
    // load the data
    try {
      final File file = await _placesFile;
      if (file.existsSync()) {
        // Read the file.
        String content = await file.readAsString();
        List<dynamic> value = jsonDecode(content);
        players.clear();
        players.addAll(value.map((val) => val.toString()));
      }
    } catch (e) {
      SpyfallDialog.showInfoDialog(title: 'Error', text: e.toString());
    }
  }
}