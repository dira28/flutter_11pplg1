import 'package:flutter/material.dart';

class ExampleMobile extends StatelessWidget {
  const ExampleMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ini Mobile")),
      body: Center(child: Text("Ini contoh mobile")),
    );
  }
}
