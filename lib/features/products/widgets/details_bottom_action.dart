import 'package:flutter/material.dart';

class DetailsBottomActions extends StatelessWidget {
  final String price;
  const DetailsBottomActions({super.key, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(color: const Color(0xFF1DBF73), borderRadius: BorderRadius.circular(20)),
          child: const Icon(Icons.favorite, color: Colors.white),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC4D),
              elevation: 0,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            ),
            onPressed: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("ADD TO CART", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.black87, fontSize: 12)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}