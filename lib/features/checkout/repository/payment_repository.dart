import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class PaymentRepository {
  final String backendUrl = "https://api.stripe.com/v1/payment_intents";

  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
    // 1. Get the secret key from your .env file
    final String secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? "";

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {
          'Authorization': 'Bearer $secretKey', // 👈 Stripe requires this header
          'Content-Type': 'application/x-www-form-urlencoded', // 👈 Corrected dash
        },
        body: {
          'amount': (amount * 100).toInt().toString(), // Stripe expects cents
          'currency': currency,
          'payment_method_types[]': 'card', // 👈 Recommended to specify
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        // This helps you debug if Stripe rejects the request
        final errorBody = jsonDecode(response.body);
        throw Exception(errorBody['error']['message'] ?? "Stripe API Error");
      }
    } catch (e) {
      throw Exception("Failed to create Payment Intent: $e");
    }
  }
}