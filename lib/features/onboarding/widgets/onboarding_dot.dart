import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class OnboardingDot extends StatelessWidget {
  final int index;
  final int currentIndex;

  const OnboardingDot({
    super.key,
    required this.index,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 8),
      height: 8,
      width: currentIndex == index ? 24 : 12,
      decoration: BoxDecoration(
        color: currentIndex == index ? AppColors.primaryGreen : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}