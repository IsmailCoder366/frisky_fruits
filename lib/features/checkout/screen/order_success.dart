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

            /// backbutton and text
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

            /// Delivery Illustration
            Image.asset(
              'assets/images/track_order.png', // Add your image here
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            const SizedBox(height: 40),

            /// Success Text
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

            ///  Description
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

            /// submit review button
            FriskyButton(
              text: 'TRACK YOUR ORDER',
              onPressed: () {
                Navigator.pushNamed(context, '/order_tracking');
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