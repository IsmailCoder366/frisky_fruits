import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onActionPressed;

  const SectionHeader({super.key, required this.title, this.onActionPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        IconButton(
          onPressed: onActionPressed,
          icon: const Icon(Icons.arrow_forward, color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}