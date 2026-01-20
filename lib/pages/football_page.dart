import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/pages/widescreen.dart/football_widescreen.dart';
import '../controllers/football_controller.dart';
import '../models/football_model.dart';
import '../routes/routes.dart';

class FootballPage extends StatelessWidget {
  FootballPage({super.key});
  final controller = Get.put(FootballController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "My Football Players",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 600) {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.players.length,
                  itemBuilder: (context, index) {
                    final FootballModel player = controller.players[index];
                    return InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.footballeditplayers,
                          arguments: {'index': index, 'player': player},
                        );
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.yellow[600],
                                backgroundImage: AssetImage(
                                  player.profileImage,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      player.name,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "${player.position} • ${player.number}",
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 18,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          } else {
            // 👉 WIDESCREEN VIEW
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: FootballWidescreen(),
            );
          }
        },
      ),
    );
  }
}
