import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/widgets/frisky_button.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: .start,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFFF2994A),
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 20),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                SizedBox(width: 50),
                Text('Order Tracking ', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 20),
            // 1. Scooter Illustration
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Image.asset(
                'assets/images/delivery_bike.png',
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            // 2. Vertical Progress Stepper
            _buildTrackingStep(
              step: "step 1",
              isCompleted: true,
              isActive: false,
              showLine: true,
            ),
            _buildTrackingStep(
              step: "step 2",
              isCompleted: false,
              isActive: true,
              showLine: true,
            ),
            _buildTrackingStep(
              step: "step 3",
              isCompleted: false,
              isActive: false,
              showLine: false,
            ),

            const SizedBox(height: 40),

            // 3. Submit Review Button
            FriskyButton(
              text: 'SUBMIT REVIEW',
              onPressed: () {
                Navigator.pushNamed(context, '/write_review');
              },
              textColor: Colors.black,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingStep({
    required String step,
    required bool isCompleted,
    required bool isActive,
    required bool showLine,
  }) {
    Color activeColor = const Color(0xFFF2994A);
    Color inactiveColor = Colors.grey[400]!;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Indicator Column (Circles and Lines)
        Column(
          children: [
            Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? activeColor : Colors.white,
                border: Border.all(
                  color: isCompleted || isActive ? activeColor : inactiveColor,
                  width: 4,
                ),
              ),
              child: isActive
                  ? const Center(
                child: CircleAvatar(radius: 4, backgroundColor: Colors.white),
              )
                  : null,
            ),
            if (showLine)
              Container(
                width: 2,
                height: 80,
                color: isCompleted ? activeColor : inactiveColor,
              ),
          ],
        ),
        const SizedBox(width: 20),
        // Text Content Column
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod",
                style: TextStyle(color: Colors.black54, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}