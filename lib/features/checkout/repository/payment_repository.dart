import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart'; // For debugPrint

class PaymentRepository {
  final String backendUrl = "https://api.stripe.com/v1/payment_intents";

  Future<Map<String, dynamic>> createPaymentIntent(double amount, String currency) async {
    // 1. Get the secret key from your .env file
    final String secretKey = dotenv.env['STRIPE_SECRET_KEY'] ?? "";

    // DEBUG: Check if the key is actually loaded
    if (secretKey.isEmpty) {
      debugPrint("❌ ERROR: Stripe Secret Key is empty! Check your .env file location and main.dart initialization.");
      throw Exception("Secret Key not found. Ensure .env is loaded in main.dart");
    } else {
      debugPrint("✅ Secret Key loaded: ${secretKey.substring(0, 7)}...");
    }

    try {
      final response = await http.post(
        Uri.parse(backendUrl),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          // Stripe expects integers in cents (e.g., $10.00 = 1000)
          'amount': (amount * 100).toInt().toString(),
          'currency': currency.toLowerCase(),
          'payment_method_types[]': 'card',
        },
      );

      final Map<String, dynamic> responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        debugPrint("🎉 Stripe PaymentIntent Created: ${responseData['id']}");
        return responseData;
      } else {
        // Detailed error from Stripe
        final String errorMessage = responseData['error']?['message'] ?? "Unknown Stripe Error";
        debugPrint("❌ Stripe API Error: $errorMessage");
        throw Exception(errorMessage);
      }
    } catch (e) {
      debugPrint("❌ Network/Parsing Error: $e");
      throw Exception("Failed to create Payment Intent: $e");
    }
  }
}