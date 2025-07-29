import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController angka1Controller = TextEditingController();
  TextEditingController angka2Controller = TextEditingController();
  String hasil = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Kalkulator",
          style: TextStyle(fontSize: 30, color: (Colors.white)),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.only(top: 60, left: 40, right: 30),
        child: Column(
          children: [
            TextField(
              controller: angka1Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Angka 1",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),

            TextField(
              controller: angka2Controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                hintText: "Angka 2",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int a = int.tryParse(angka1Controller.text) ?? 0;
                      int b = int.tryParse(angka2Controller.text) ?? 0;
                      hasil = (a + b).toString();
                    });
                  },
                  child: Text(
                    '+',
                    style: TextStyle(fontSize: 30, color: (Colors.black)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int a = int.tryParse(angka1Controller.text) ?? 0;
                      int b = int.tryParse(angka2Controller.text) ?? 0;
                      hasil = (a - b).toString();
                    });
                  },
                  child: Text(
                    '-',
                    style: TextStyle(fontSize: 30, color: (Colors.black)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int a = int.tryParse(angka1Controller.text) ?? 0;
                      int b = int.tryParse(angka2Controller.text) ?? 0;
                      hasil = (a * b).toString();
                    });
                  },
                  child: Text(
                    'x',
                    style: TextStyle(fontSize: 30, color: (Colors.black)),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      int a = int.tryParse(angka1Controller.text) ?? 0;
                      int b = int.tryParse(angka2Controller.text) ?? 0;
                      if (b != 0) {
                        hasil = (a ~/ b).toString();
                      } else {
                        hasil = 'Tidak bisa dibagi 0';
                      }
                    });
                  },
                  child: Text(
                    '/',
                    style: TextStyle(fontSize: 30, color: (Colors.black)),
                  ),
                ),
              ],
            ),
            SizedBox(height: 50),
            Text("Hasil: $hasil", style: TextStyle(fontSize: 20)),
            SizedBox(height: 100),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),

              onPressed: () {
                setState(() {
                  angka1Controller.clear();
                  angka2Controller.clear();
                  hasil = '';
                });
              },
              child: Text(
                "Clear",
                style: TextStyle(
                  fontSize: 30,
                  color: (Colors.white),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
