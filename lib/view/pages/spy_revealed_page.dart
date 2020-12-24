
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/data/place.dart';
import 'package:spyfall/view/app_bar.dart';
import 'package:spyfall/view/pages/pages.dart';
import 'package:spyfall/view/spy_guess_place.dart';

class SpyRevealedPage extends StatefulWidget {
  @override
  _SpyRevealedPageState createState() => _SpyRevealedPageState();
}

class _SpyRevealedPageState extends State<SpyRevealedPage> {

  String _spy;
  Place _place;
  List<Place> _placesPool;

  @override
  void initState(){
    super.initState();
    _spy = Get.arguments['spy'];
    _place = Get.arguments['place'];
    _placesPool = Get.arguments['placesPool'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: SpyfallAppBar(
        text: 'Spy Guess Place',
      ),
      body: SpyGuessPlace(
        playerName: _spy,
        placesPool: _placesPool,
        onPlaceChosen: (Place place){
          if(place == _place){
            Get.offNamed(Pages.gameEnded, arguments: {
              'place': _place,
              'spy': _spy,
              'description':
              'Spy revealed themselves and guessed the place correctly.',
              'winnerTitle': 'Spy wins',
            });
          }else{
            Get.offNamed(Pages.gameEnded, arguments: {
              'place': _place,
              'spy': _spy,
              'description':
              'Spy revealed themselves but guessed the place incorrectly',
              'winnerTitle': 'Member wins',
            });
          }
        },
      ),
    );
  }
}
