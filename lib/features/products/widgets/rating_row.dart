import 'package:flutter/material.dart';

class RatingRow extends StatelessWidget {
  const RatingRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star, color: Color(0xFFFFCC4D), size: 22),
        const Text(" 4.5", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        Text(" (128 reviews)", style: TextStyle(color: Colors.grey.shade400)),
        const Spacer(),
        const SizedBox(
          width: 90,
          height: 40,
          child: Stack(
            children: [
              _PositionedAvatar(left: 0, image: 'assets/images/review1.png'),
              _PositionedAvatar(left: 20, image: 'assets/images/review2.png'),
              _PositionedAvatar(left: 40, image: 'assets/images/review3.png'),
            ],
          ),
        )
      ],
    );
  }
}

class _PositionedAvatar extends StatelessWidget {
  final double left;
  final String image;
  const _PositionedAvatar({required this.left, required this.image});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left,
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.white,
        child: CircleAvatar(radius: 16, backgroundImage: AssetImage(image)),
      ),
    );
  }
}