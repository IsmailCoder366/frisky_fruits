import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String userName;
  const HomeHeader({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Good Morning", style: TextStyle(color: Colors.grey, fontSize: 16)),
            Text(userName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        const Icon(Icons.notifications_none_outlined, size: 28),
      ],
    );
  }
}