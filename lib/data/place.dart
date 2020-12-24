import 'dart:convert';
import 'dart:io';

import 'package:spyfall/file_util.dart';
import 'package:spyfall/view/dialog.dart';

class Place {
  static final List<Place> places = new List<Place>();

  static const List<Place> defaultPlaces = const [
    Place(
      name: 'Airplane',
      roles: [
        'First Class Passenger',
        'Mechanic',
        'Air Hostess',
        'Co-Pilot',
        'Captain',
        'Economy Class Passenger',
      ],
    ),
    Place(
      name: 'Bank',
      roles: [
        'Manager',
        'Security Guard',
        'Robber',
        'Customer',
        'Staff',
      ],
    ),
    Place(
      name: 'Casino',
      roles: [
        'Bartender',
        'Security Guard',
        'Manager',
        'Dealer',
        'Gambler',
      ],
    ),
    Place(
      name: 'Hospital',
      roles: [
        'Nurse',
        'Doctor',
        'Patient',
        'Surgeon',
      ],
    ),
    Place(
      name: 'Hotel',
      roles: [
        'Maid',
        'Security Guard',
        'Manager',
        'Bartender',
        'Bellman',
        'Customer',
      ],
    ),
    Place(
      name: 'Police Station',
      roles: [
        'Police',
        'Criminal',
        'Detective',
        'Lawyer',
        'News Reporter',
      ],
    ),
    Place(
      name: 'Restaurant',
      roles: [
        'Musician',
        'Waiter',
        'Chef',
        'Head Chef',
        'Reviewer',
      ],
    ),
    Place(
      name: 'School',
      roles: [
        'Janitor',
        'Student',
        'Librarian',
        'Teacher',
        'Principal',
      ],
    ),
    Place(
      name: 'Concert',
      roles: [
        'Dancer',
        'Singer',
        'Guitarist',
        'Drummer',
        'Bassist',
        'Sound Engineer',
        'FanClub',
      ],
    ),
  ];

  static Future<File> get _placesFile async {
    return File('${await FileUtils.localPath}/places.json');
  }

  /// save the current place data into local path file (places.json)
  static void save() async {
    try {
      final File file = await _placesFile;
      file.writeAsString(jsonEncode(places.map((e) => e.toJson()).toList()));
    } catch (e) {
      SpyfallDialog.showInfoDialog(title: 'Error', text: e.toString());
    }
  }

  /// Load the places data from local path file (places.json), or load the default places
  /// data if the file does not exists. Should be called only once when the app starts. The loaded data
  /// will go into this class' static instance 'places'.
  static Future<void> load() async {
    // load the data
    try {
      final File file = await _placesFile;
      if (file.existsSync()) {
        // Read the file.
        String content = await file.readAsString();
        List<dynamic> value = jsonDecode(content);
        places.clear();
        places.addAll(value.map((val) => Place.fromJson(val)));
      } else {
        // use the default data
        places.clear();
        places.addAll(defaultPlaces);
      }
   } catch (e) {
      SpyfallDialog.showInfoDialog(title: 'Error', text: e.toString());
    }
  }

  final String name;
  final List<String> roles;

  const Place({this.name, this.roles});

  Place.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        roles = List.of((json['roles'] as List<dynamic>).map((e) => e.toString()));

  /// Create a new instance of place with the given name and has the same roles as this place.
  Place withName(String val) {
    return Place(name: val, roles: List.from(roles));
  }

  /// Create a new instance of place with the given list of role and has the same name as this place.
  Place withRoles(List<String> r) {
    return Place(name: name, roles: List.from(r));
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'roles': List.of(roles),
    };
  }

  Place clone() {
    return Place(name: name, roles: List.from(roles));
  }
}
