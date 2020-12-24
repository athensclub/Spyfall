import 'package:flutter/material.dart';

class SpyfallListView extends StatelessWidget {
  int itemCount;
  Widget Function(BuildContext, int) itemBuilder;

  SpyfallListView({this.itemCount, this.itemBuilder});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[850],
      child: ListView.separated(
        padding: EdgeInsets.all(12.0),
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Colors.grey[800],
          height: 30.0,
        ),
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
