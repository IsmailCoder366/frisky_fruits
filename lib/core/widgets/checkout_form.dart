import 'package:flutter/material.dart';

class CheckoutFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isOrange;
  final TextEditingController? controller;
  final DropdownButtonFormField? dropdownButtonFormField;

  const CheckoutFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isOrange = false,
    this.controller, this.dropdownButtonFormField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 15),
          child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(color: isOrange ? const Color(0xFFF2994A) : Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFFF2994A), width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}