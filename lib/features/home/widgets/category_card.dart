import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  const CategoryCard({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 2)],
      ),
      child: Icon(icon, color: Colors.purple, size: 30),
    );
  }
}