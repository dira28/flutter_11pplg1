import 'package:get/get.dart';
import '../models/football_model.dart';

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
      position: "Midfielder",
      number: 11,
    ),
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 3",
      position: "Defender",
      number: 5,
    ),
    FootballModel(
      profileImage: "assets/profiile.png",
      name: "Player 4",
      position: "Goalkeeper",
      number: 1,
    ),
  ].obs;

  void updatePlayer(int index, FootballModel updatedPlayer) {
    players[index] = updatedPlayer;
  }

  void addPlayer(FootballModel newPlayer) {
    players.add(newPlayer);
  }

  void removePlayer(int index) {
    players.removeAt(index);
  }
}
