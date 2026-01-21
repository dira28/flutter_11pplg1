import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:http/http.dart' as http;

void main() async {
  final router = Router();

  router.post('/get-snap-token', (Request request) async {
    final payload = jsonDecode(await request.readAsString());
    
    // SERVER KEY ANDA (Gunakan Server Key Sandbox jika ingin simulasi)
    const serverKey = ''; 
    final auth = 'Basic ${base64.encode(utf8.encode('$serverKey:'))}';

    try {
      final response = await http.post(
        Uri.parse('https://app.sandbox.midtrans.com/snap/v1/transactions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': auth,
        },
        body: jsonEncode({
          "transaction_details": {
            "order_id": "MOVIE-${DateTime.now().millisecondsSinceEpoch}",
            "gross_amount": payload['amount']
          },
          "item_details": [{
            "id": "item-01",
            "price": payload['amount'],
            "quantity": 1,
            "name": payload['movie_title']
          }]
        }),
      );

      return Response.ok(response.body, headers: {'Content-Type': 'application/json'});
    } catch (e) {
      return Response.internalServerError(body: e.toString());
    }
  });

  final server = await serve(router, InternetAddress.anyIPv4, 3000);
  print('Server Backend Sandbox jalan di: http://${server.address.host}:${server.port}');
}