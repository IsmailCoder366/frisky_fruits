import 'package:flutter/material.dart';

class CheckoutProgressBar extends StatelessWidget {
  final int currentStep; // 1: Shipping, 2: Payment

  const CheckoutProgressBar({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
      color: const Color(0xFFF8F9FB), // Light grey background section
      child: Column(
        children: [
          Stack(
            alignment: Alignment.centerLeft, // Align from left to grow line
            children: [
              // 1. Full Background Line (Grey)
              Container(
                height: 2,
                width: double.infinity,
                color: Colors.grey[300],
              ),

              // 2. Fractional Active Line (Orange)
              // This grows to 50% for step 1, 100% for step 2
              FractionallySizedBox(
                widthFactor: currentStep == 1 ? 0.5 : 1.0,
                child: Container(
                  height: 2,
                  color: const Color(0xFFF2994A),
                ),
              ),

              // 3. Circles and Titles
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStepCircle(
                      isActive: currentStep == 1,
                      isDone: currentStep > 1
                  ),
                  _buildStepCircle(
                      isActive: currentStep == 2,
                      isDone: false
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 15),

          // 4. Text Labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Shipping Address",
                style: TextStyle(
                  color: currentStep >= 1 ? Colors.black : Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              Text(
                "Payment Method",
                style: TextStyle(
                  color: currentStep == 2 ? Colors.black : Colors.grey[400],
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStepCircle({required bool isActive, required bool isDone}) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // If the step is done or currently active, it gets the orange color
        color: isDone || isActive ? const Color(0xFFF2994A) : Colors.grey[300],
        border: Border.all(color: Colors.white, width: 2),
        boxShadow: [
          if (isActive || isDone)
            BoxShadow(
              color: const Color(0xFFF2994A).withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: isActive && !isDone
          ? Center(
        child: Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      )
          : null,
    );
  }
}