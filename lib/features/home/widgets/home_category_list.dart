import 'package:flutter/material.dart';
import 'category_card.dart';

class HomeCategoryList extends StatelessWidget {
  const HomeCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryCard(images: 'assets/images/vegetable_cat.png'),
          CategoryCard(images: 'assets/images/mushroom_cat.png'),
          CategoryCard(images: 'assets/images/milk_cat.png'),
          CategoryCard(images: 'assets/images/vegetable_cat.png'),
        ],
      ),
    );
  }
}