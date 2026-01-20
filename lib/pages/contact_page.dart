import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latihan1_11pplg1/widgets/widget_textfield.dart';
import 'package:latihan1_11pplg1/widgets/widget_button.dart'; // import CustomButton
import '../controllers/contact_controller.dart';

class ContactPage extends StatelessWidget {
  final controller = Get.find<ContactController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contacts"),
        centerTitle: true,
        backgroundColor: Colors.yellow[600],
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    textEditingController: controller.nameController,
                    hintText: "Enter contact name",
                  ),
                ),
                const SizedBox(width: 10),
                CustomButton(
                  text: "Save",
                  backgroundColor: Colors.yellow[600]!,
                  textColor: Colors.black,
                  onPressed: () => controller.addName(),
                ),
              ],
            ),
            const SizedBox(height: 20),

            Expanded(
              child: Obx(() {
                if (controller.names.isEmpty) {
                  return const Center(
                    child: Text(
                      "No contacts yet",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.names.length,
                  itemBuilder: (context, index) {
                    final contact = controller.names[index];
                    return Dismissible(
                      key: Key(contact['id'].toString()),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red[400],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.delete, color: Colors.white),
                      ),
                      onDismissed: (_) {
                        controller.deleteName(contact['id']);
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.person,
                            color: Colors.black,
                          ),
                          title: Text(contact['name']),
                          trailing: IconButton(
                            icon: const Icon(Icons.edit, color: Colors.black),
                            onPressed: () {
                              final editController = TextEditingController(
                                text: contact['name'],
                              );
                              Get.defaultDialog(
                                title: "Edit Contact",
                                backgroundColor: Colors.yellow[50],
                                titleStyle: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                                content: Column(
                                  children: [
                                    TextField(
                                      controller: editController,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: "Enter new name",
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // Cancel pakai CustomButton
                                        Expanded(
                                          child: CustomButton(
                                            text: "Cancel",
                                            backgroundColor: Colors.red[400]!,
                                            textColor: Colors.white,
                                            onPressed: () => Get.back(),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        // Save pakai CustomButton
                                        Expanded(
                                          child: CustomButton(
                                            text: "Save",
                                            backgroundColor:
                                                Colors.yellow[600]!,
                                            textColor: Colors.black,
                                            onPressed: () {
                                              controller.updateName(
                                                contact['id'],
                                                editController.text.trim(),
                                              );
                                              Get.back();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
