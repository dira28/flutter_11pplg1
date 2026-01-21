import 'dart:convert';
import 'package:http/http.dart' as http;

class MidtransProvider {
  final String baseUrl = "http://10.0.2.2:3000/get-snap-token";

  Future<String?> fetchSnapToken(int amount, String title) async {
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'movie_title': title,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['token'];
      }
    } catch (e) {
      print("Midtrans Provider Error: $e");
    }
    return null;
  }
}