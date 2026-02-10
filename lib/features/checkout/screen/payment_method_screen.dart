import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/widgets/frisky_button.dart';
import '../../../core/widgets/checkout_dropdown_field.dart';
import '../../../core/widgets/checkout_form.dart';
import '../widgets/checkout_progress.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  // State variables to track selection
  bool isCreditCard = true;
  int selectedCardIndex = 0;

  // List of card images
  final List<String> cardImages = [
    'assets/images/gold_card.png',
    'assets/images/grey_card.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CheckoutProgressBar(currentStep: 2),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Method Selector
                  Row(
                    children: [
                      Expanded(
                        child: _buildTypeButton("Cash on Delivery", !isCreditCard, () {
                          setState(() => isCreditCard = false);
                        }),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: _buildTypeButton("Credit Card", isCreditCard, () {
                          setState(() => isCreditCard = true);
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // 2. Dynamic Content Section
                  if (isCreditCard) ...[
                    // --- Show this only when Credit Card is selected ---
                    const Text("Select Card", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 15),
                    _buildHorizontalCardList(),
                    const SizedBox(height: 20),
                    const CheckoutFormField(label: "Card Holder Name", hint: "M.Ismail"),
                    const CheckoutFormField(label: "Card Number", hint: "333 4444 5555 6666"),
                    Row(
                      children: [
                        Expanded(child: CheckoutFormField(label: "Month/Year", hint: "MM/YY")),
                        const SizedBox(width: 15),
                        Expanded(child: CheckoutFormField(label: "CVV", hint: "Enter here")),
                      ],
                    ),
                    CheckoutDropdownField(
                      label: "Country",
                      hint: "Choose your country",
                      items: const ["Pakistan", "USA", 'Dubai', 'India'],
                      onChanged: (value) {},
                    ),
                  ] else ...[
                    // --- Show this only when Cash on Delivery is selected ---
                    _buildCashOnDeliveryInfo(),
                  ],

                  const SizedBox(height: 30),
                  FriskyButton(
                    text: 'Confirm order',
                    onPressed: () {
                     Navigator.pushNamed(context, '/order_success');
                    },
                    textColor: Colors.black,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Horizontal Scrollable Cards with Selection
  Widget _buildHorizontalCardList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: cardImages.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedCardIndex == index;
          return GestureDetector(
            onTap: () => setState(() => selectedCardIndex = index),
            child: Container(
              margin: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: isSelected ? const Color(0xFFF2994A) : Colors.transparent,
                  width: 3,
                ),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(cardImages[index], width: 260, fit: BoxFit.fill),
                  ),
                  if (isSelected)
                    const Positioned(
                      top: 10,
                      right: 10,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.check, color: Color(0xFFF2994A), size: 18),
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // Cash on Delivery specific UI
  Widget _buildCashOnDeliveryInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Row(
        children: [
          Icon(Icons.info_outline, color: Colors.grey),
          SizedBox(width: 15),
          Expanded(
            child: Text(
              "You will pay when your order is delivered to your doorstep.",
              style: TextStyle(color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Type Button with Callback
  Widget _buildTypeButton(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFCC4D) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: isSelected ? Colors.transparent : Colors.grey[300]!),
        ),
        child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}