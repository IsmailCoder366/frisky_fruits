import 'package:flutter/material.dart';

class DealCard extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;

  const DealCard({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(top: 10, left: 10, child: Icon(Icons.favorite, color: Colors.red.shade400)),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
    );
  }
}