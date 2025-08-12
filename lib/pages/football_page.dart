import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/football_controller.dart';
import 'package:latihan1_11pplg1/models/football_model.dart';
import 'package:latihan1_11pplg1/routes/routes.dart';

class FootballPage extends StatelessWidget {
  FootballPage({super.key});
  final FootballController footballController = Get.put(FootballController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Football Player")),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Obx(
          () => ListView.builder(
            itemCount: footballController.players.length,
            itemBuilder: (context, index) {
              FootballModel player = footballController.players[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(player.profileImage),
                ),
                title: Text(player.name),
                subtitle: Text("${player.position}. ${player.number}"),
                onTap: () {
                  Get.toNamed(
                    AppRoutes.footballeditplayers,
                    arguments: {'index': index, 'player': player},
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
