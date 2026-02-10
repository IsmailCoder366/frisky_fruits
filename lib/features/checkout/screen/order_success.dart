import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/widgets/frisky_button.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundColor: const Color(0xFFF2994A),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () {
                      // Navigate back to Home and clear the stack
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 110),
                Text('Thank You', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),)

              ],
            ),
            SizedBox(height: 20),
            // 1. Delivery Illustration
            Image.asset(
              'assets/images/track_order.png', // Add your image here
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const SizedBox(height: 40),

            // 2. Success Text
            const Text(
              "Your Order in process",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 15),

            // 3. Description
            const Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black54,
                height: 1.5,
              ),
            ),
            const Spacer(),

            // 4. Track Order Button
            FriskyButton(
              text: 'TRACK YOUR ORDER',
              onPressed: () {
                // Future: Navigate to Order Tracking Screen
              },
              textColor: Colors.black,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}