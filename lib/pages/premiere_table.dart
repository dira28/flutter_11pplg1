import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/controllers/premiere_controller.dart';

class PremiereTable extends StatelessWidget {
  PremiereTable({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PremierTableController>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Premiere League Table",
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.yellow[700],
        centerTitle: true,
        elevation: 2,
        iconTheme: IconThemeData(color: Colors.black87),
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }
          return RefreshIndicator(
            onRefresh: () {
              return controller.fetchPremierTable();
            },
            child: ListView.builder(
              itemCount: controller.standing.length,
              itemBuilder: (context, index) {
                final team = controller.standing[index];
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 4),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    color: Colors.white,
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      leading: CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: NetworkImage(team.strBadge.toString()),
                      ),
                      title: Text(
                        team.strTeam.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      trailing: Text(team.intPoints),
                      subtitle: Text(
                        "Played: " +
                            team.intPlayed.toString() +
                            "  W: " +
                            team.intWin.toString() +
                            "  D: " +
                            team.intDraw.toString() +
                            "  L: " +
                            team.intLoss.toString(),
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
