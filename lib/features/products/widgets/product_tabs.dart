import 'package:flutter/material.dart';

class ProductTabs extends StatelessWidget {
  const ProductTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: const TabBar(
        // Makes the indicator and text alignment clean
        isScrollable: false,
        labelColor: Colors.black,
        unselectedLabelColor: Colors.grey,

        // Customizing the indicator to match Fruisky Fruits design
        indicatorColor: Color(0xFFFFCC4D),
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 3,

        labelStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          fontFamily: 'Poppins', // Or your project's font
        ),
        unselectedLabelStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16
        ),

        tabs: [
          Tab(text: "Description"),
          Tab(text: "Review"),
          Tab(text: "Discussion"),
        ],
      ),
    );
  }
}