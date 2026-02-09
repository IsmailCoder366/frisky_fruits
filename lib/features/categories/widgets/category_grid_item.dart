// ... imports

import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../models/category_model.dart';

class CategoryGridItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.category,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Simply triggers the handleSelection logic above
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.lightYellow : Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 5,
              spreadRadius: 5,
              offset: const Offset(5, 5),
            )
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: isSelected
                  ? const ColorFilter.mode(Colors.black, BlendMode.srcIn)
                  : const ColorFilter.mode(Colors.transparent, BlendMode.multiply),
              child: Image.asset(category.imagePath, height: 70),
            ),
            const SizedBox(height: 12),
            Text(
              category.name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.black : AppColors.orangeText,
              ),
            ),
            Text(
              "${category.itemCount} Items",
              style: TextStyle(
                fontSize: 12,
                color: isSelected ? Colors.black54 : Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}