import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/football_controller.dart';
import '../../models/football_model.dart';
import '../../routes/routes.dart';

class FootballWidescreen extends StatelessWidget {
  final footballController = Get.find<FootballController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 3.5,
        ),
        itemCount: footballController.players.length,
        itemBuilder: (context, index) {
          FootballModel player = footballController.players[index];

          return GestureDetector(
            onTap: () {
              Get.toNamed(
                AppRoutes.footballeditplayers,
                arguments: {'index': index, 'player': player},
              );
            },
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.yellow[600],
                      backgroundImage: AssetImage(player.profileImage),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                    const Icon(Icons.edit, color: Colors.grey, size: 20),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
