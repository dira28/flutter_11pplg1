import 'package:get/get.dart';
import 'package:latihan1_11pplg1/models/football_model.dart';

class FootballController extends GetxController {
  var players = <FootballModel>[
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 1",
      position: "Forward",
      number: 10,
    ),
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 2",
      position: "Forward",
      number: 11,
    ),
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 3",
      position: "Forward",
      number: 5,
    ),
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 4",
      position: "Forward",
      number: 7,
    ),
  ].obs;

  void updatePlayer(int index, FootballModel updatedPlayer) {
    players[index] = updatedPlayer;
  }
}
