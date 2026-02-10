import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/widgets/frisky_button.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/checkout_dropdown_field.dart';
import '../../../core/widgets/checkout_form.dart';
import '../widgets/checkout_progress.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout"), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            const CheckoutProgressBar(currentStep: 1),
            const CheckoutFormField(label: "Full Name", hint: "Enter Full Name"),
            const CheckoutFormField(label: "Email Address", hint: "Enter Email address"),
            const CheckoutFormField(label: "Phone", hint: "Enter Phone No"),


            // Reusing for smaller fields in a Row
            Row(
              children: [
                Expanded(child: CheckoutFormField(label: "Zip Code", hint: "Enter here")),
                const SizedBox(width: 15),
                Expanded(child: CheckoutFormField(label: "City", hint: "Enter here")),
              ],
            ),
            // Inside CheckoutScreen's Column
             CheckoutDropdownField(
              label: "Country",
              hint: "Choose your country",
              items: ["Pakistan", "United States", "United Kingdom", "United Arab Emirates"],
              onChanged: (value) {
                print("Selected Country: $value");
              },
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.check_box_outlined, color: Colors.green),
                SizedBox(width: 4),
                Text('Save shipping address')
              ],
            ),

            const SizedBox(height: 40),
            // Reusable Button Logic
            FriskyButton(
                text: 'Next',
                onPressed: (){
                  Navigator.pushNamed(context, '/paymentMethod');
                },
                textColor: Colors.black
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}