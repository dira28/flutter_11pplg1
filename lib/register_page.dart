import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final namaController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String jenisKelamin = 'Laki-laki';
  DateTime? tanggalLahir;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Register",
          style: TextStyle(fontSize: 30, color: (Colors.white)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            inputField("Nama lengkap", namaController),
            SizedBox(height: 10),
            inputField("Email / Username", emailController),
            SizedBox(height: 10),
            inputField("Password", passwordController, obscure: true),
            SizedBox(height: 20),
            Text(
              "Jenis Kelamin",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Radio(
                  activeColor: Colors.blue,
                  value: 'Laki-laki',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value.toString();
                    });
                  },
                ),
                Text("Laki-laki"),
                Radio(
                  activeColor: Colors.pink,
                  value: 'Perempuan',
                  groupValue: jenisKelamin,
                  onChanged: (value) {
                    setState(() {
                      jenisKelamin = value.toString();
                    });
                  },
                ),
                Text("Perempuan"),
              ],
            ),
            SizedBox(height: 20),
            Text(
              "Tanggal Lahir",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime(2009),
                  firstDate: DateTime(1990),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  setState(() {
                    tanggalLahir = pickedDate;
                  });
                }
              },
              child: Text(
                tanggalLahir == null
                    ? 'Pilih Tanggal'
                    : tanggalLahir.toString().split(' ')[0],
                style: TextStyle(fontSize: 16, color: (Colors.white)),
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                if (namaController.text.isEmpty ||
                    emailController.text.isEmpty ||
                    passwordController.text.isEmpty ||
                    tanggalLahir == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Semua kolom wajib diisi'),
                      backgroundColor: Colors.red,
                    ),
                  );
                } else {
                  print('DATA REGISTER');
                  print('Nama          : ${namaController.text}');
                  print('Email/Username: ${emailController.text}');
                  print('Password      : ${passwordController.text}');
                  print('Jenis Kelamin : $jenisKelamin');
                  print(
                    'Tanggal Lahir : ${tanggalLahir.toString().split(' ')[0]}',
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Berhasil Daftar!'),
                      backgroundColor: Colors.cyan,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Daftar",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget inputField(
    String label,
    TextEditingController controller, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.teal, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
