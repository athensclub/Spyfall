import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spyfall/view/pages/choose_places_page.dart';
import 'package:spyfall/view/pages/edit_places_page.dart';
import 'package:spyfall/view/pages/edit_single_place_page.dart';
import 'package:spyfall/view/pages/game_ended_page.dart';
import 'package:spyfall/view/pages/home_page.dart';
import 'package:spyfall/view/pages/loading_page.dart';
import 'package:spyfall/view/pages/pages.dart';
import 'package:spyfall/view/pages/player_settings_page.dart';
import 'package:spyfall/view/pages/spy_revealed_page.dart';
import 'package:spyfall/view/pages/timer_page.dart';
import 'package:spyfall/view/pages/view_role_page.dart';
import 'package:spyfall/view/pages/vote_page.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: Pages.loading,
    getPages: [
      GetPage(name: Pages.editSinglePlace, page: () => EditSinglePlacePage()),
      GetPage(name: Pages.loading, page: () => LoadingPage()),
      GetPage(name: Pages.home, page: () => HomePage()),
      GetPage(name: Pages.editPlaces, page: () => EditPlacesPage()),
      GetPage(name: Pages.playerSettings, page: () => PlayerSettingsPage()),
      GetPage(name: Pages.choosePlaces, page: () => ChoosePlacesPage()),
      GetPage(name: Pages.viewRole, page: () => ViewRolePage()),
      GetPage(name: Pages.timer, page: () => TimerPage()),
      GetPage(name: Pages.vote, page: () => VotePage()),
      GetPage(name: Pages.gameEnded, page: () => GameEndedPage()),
      GetPage(name: Pages.spyRevealed, page: () => SpyRevealedPage()),
    ],
  ));
}
