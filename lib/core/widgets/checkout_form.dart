import 'package:flutter/material.dart';

class CheckoutFormField extends StatelessWidget {
  final String label;
  final String hint;
  final bool isOrange;
  final TextEditingController? controller;
  final bool readOnly; // 👈 Added to prevent typing when using DatePicker
  final VoidCallback? onTap; // 👈 Added to trigger the DatePicker
  final Widget? suffixIcon; // 👈 Useful for adding icons like 'calendar'

  const CheckoutFormField({
    super.key,
    required this.label,
    required this.hint,
    this.isOrange = false,
    this.controller,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, top: 15),
          child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)
          ),
        ),
        TextField(
          controller: controller,
          readOnly: readOnly, // Use this for the Month/Year selection
          onTap: onTap,       // Triggers your _pickExpiryDate function
          decoration: InputDecoration(
            hintText: hint,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide(
                  color: isOrange ? const Color(0xFFF2994A) : Colors.grey[200]!
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: Color(0xFFF2994A), width: 1.5),
            ),
            // Style for when the field is read-only but still clickable
            filled: readOnly,
            fillColor: readOnly ? Colors.grey[50] : Colors.transparent,
          ),
        ),
      ],
    );
  }
}