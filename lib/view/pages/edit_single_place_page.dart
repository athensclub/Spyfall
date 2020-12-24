import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/SpyfallListView.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/dialog.dart';
import 'package:spyfall/view/floating_action_button.dart';

class EditSinglePlacePage extends StatefulWidget {
  @override
  _EditSinglePlacePageState createState() => _EditSinglePlacePageState();
}

class _EditSinglePlacePageState extends State<EditSinglePlacePage> {
  List<String> _roles;
  String _name;
  bool Function(String) _placeExists;

  @override
  void initState() {
    super.initState();
    _roles = List.of(Get.arguments['roles']);
    _name = Get.arguments['name'];
    _placeExists = Get.arguments['placeExists'];
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Edit Place',
      ),
      body: WillPopScope(
        onWillPop: () async {
          Get.back(
            result: Place(
              name: _name,
              roles: _roles,
            ),
          );
          return false;
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.orange,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      _name,
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.grey[100],
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.orange,
                    ),
                    onPressed: () {
                      SpyfallDialog.showInputDialog(
                        labelText: 'Place Name',
                        hintText: 'Enter place name here.',
                        onReceiveInput: (String str) {
                          if (str.isNotEmpty) {
                            if (_placeExists(str) && str != _name) {
                              SpyfallDialog.showInfoDialog(
                                  title: 'Error',
                                  text:
                                      'Place with name "$str" already exists!');
                            } else {
                              setState(() {
                                _name = str;
                              });
                            }
                          }
                        },
                      );
                    },
                  )
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Roles',
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.orange,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SpyfallListView(
                    itemCount: _roles.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              _roles[index],
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
                                    'Are you sure you want to delete role ${_roles[index]}?',
                                onConfirm: () {
                                  setState(() {
                                    _roles.removeAt(index);
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
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SpyfallFloatingActionButtonAdd(
        onPressed: () {
          SpyfallDialog.showInputDialog(
              labelText: 'Add Role',
              hintText: 'Enter role name here.',
              onReceiveInput: (String str) {
                if (str.isNotEmpty) {
                  setState(() {
                    _roles.add(str);
                  });
                }
              });
        },
      ),
    );
  }
}
