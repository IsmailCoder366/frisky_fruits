import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../../core/widgets/frisky_button.dart';
import '../../../../core/widgets/checkout_form.dart';
import '../widgets/checkout_progress.dart';
import '../bloc/payment_bloc.dart';
import '../bloc/payment_event.dart';
import '../bloc/payment_state.dart';
import '../../products/bloc/cart_bloc/cart_bloc.dart';
import '../../products/bloc/cart_bloc/cart_state.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  bool isCreditCard = false;
  int selectedCardIndex = 0;
  final TextEditingController _expiryController = TextEditingController();

  final List<String> cardImages = [
    'assets/images/gold_card.png',
    'assets/images/grey_card.png',
  ];

  // Logic to show only Month and Year Picker
  Future<void> _pickExpiryDate() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 300,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Select Expiry Date", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              Expanded(
                child: CalendarDatePicker(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2040),
                  onDateChanged: (DateTime date) {
                    setState(() {
                      _expiryController.text = DateFormat('MM/yy').format(date);
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, cartState) {
        // Calculate Total Price from Cart items
        double totalToPay = cartState.totalAmount;

        return BlocListener<PaymentBloc, PaymentState>(
          listener: (context, state) {
            if (state is PaymentSuccess) Navigator.pushNamed(context, '/order_success');
            if (state is PaymentFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error), backgroundColor: Colors.red),
              );
            }
          },
          child: BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, paymentState) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text("Checkout", style: TextStyle(fontWeight: FontWeight.bold)),
                  centerTitle: true,
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  elevation: 0,
                ),
                body: Stack(
                  children: [
                    SingleChildScrollView(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CheckoutProgressBar(currentStep: 2),
                          const SizedBox(height: 20),
                          _buildTypeSelector(),
                          const SizedBox(height: 30),

                          if (isCreditCard) ...[
                            _buildCardSection(),
                            const CheckoutFormField(label: "Card Holder Name", hint: "M. Ismail"),
                            const CheckoutFormField(label: "Card Number", hint: "333 4444 5555 6666"),
                            Row(
                              children: [
                                Expanded(
                                  child: CheckoutFormField(
                                    label: "Month/Year",
                                    hint: "MM/YY",
                                    controller: _expiryController,
                                    readOnly: true,
                                    onTap: _pickExpiryDate,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                const Expanded(child: CheckoutFormField(label: "CVV", hint: "123")),
                              ],
                            ),
                          ] else ...[
                            _buildCashOnDeliveryInfo(),
                          ],

                          const SizedBox(height: 40),

                          // --- TOTAL PRICE SUMMARY ---
                          _buildPriceSummary(totalToPay),

                          const SizedBox(height: 20),

                          FriskyButton(
                            text: paymentState is PaymentLoading ? 'Processing...' : 'Confirm order',
                            onPressed: paymentState is PaymentLoading
                                ? null
                                : () {
                              if (isCreditCard) {
                                context.read<PaymentBloc>().add(ProcessStripePayment(totalToPay));
                              } else {
                                Navigator.pushNamed(context, '/order_success');
                              }
                            },
                            textColor: Colors.black,
                          )
                        ],
                      ),
                    ),
                    if (paymentState is PaymentLoading)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(child: CircularProgressIndicator(color: Color(0xFFF2994A))),
                      ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // --- Sub-Widgets ---

  Widget _buildPriceSummary(double total) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF9F0),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFFFCC4D).withOpacity(0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Total Payable", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          Text("\$${total.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1DBF73))),
        ],
      ),
    );
  }

  Widget _buildTypeSelector() {
    return Row(
      children: [
        Expanded(child: _buildTypeButton("Cash", !isCreditCard, () => setState(() => isCreditCard = false))),
        const SizedBox(width: 15),
        Expanded(child: _buildTypeButton("Card", isCreditCard, () => setState(() => isCreditCard = true))),
      ],
    );
  }

  Widget _buildCardSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Card", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 15),
        SizedBox(
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
                    border: Border.all(color: isSelected ? const Color(0xFFF2994A) : Colors.transparent, width: 3),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(cardImages[index], width: 260, height: 160, fit: BoxFit.fill),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 25),
      ],
    );
  }

  Widget _buildCashOnDeliveryInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(15)),
      child: const Row(
        children: [
          Icon(Icons.delivery_dining, color: Color(0xFF1DBF73), size: 30),
          SizedBox(width: 15),
          Expanded(child: Text("Pay in cash when our rider reaches your doorstep.")),
        ],
      ),
    );
  }

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