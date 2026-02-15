import 'dart:convert';
import 'package:http/http.dart' as http;

class PaymentRepository {
  // Replace with your actual backend URL (Firebase Function or Node.js)
  final String backendUrl = "https://api.stripe.com/v1/payment-intent";

  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        body: {
          'amount': (amount * 100).toInt().toString(), // Stripe expects cents
          'currency': currency,
        },
        headers: {
          'Authorization': 'Bearer sk_test_51T10eBD10vI0fYchWUoPKPunWA6o9PEZDihYb6pWefTxcf9UpOeThy8uxCor6JIg0xNfM7nYutq2CaMM0V6vrYfn00MNEEDCVW',
          'Content_Type' : 'application/x-www-form-urlencoded'
        }
      );
      return jsonDecode(response.body);
    } catch (e) {
      throw Exception("Failed to create Payment Intent: $e");
    }
  }
}