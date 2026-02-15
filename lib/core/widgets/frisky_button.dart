import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class FriskyButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // 👈 Changed: Added '?' to make it nullable
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double height;

  const FriskyButton({
    super.key,
    required this.text,
    this.onPressed, // 👈 Changed: Removed 'required' because null is now allowed
    this.backgroundColor,
    this.width,
    this.height = 60.0,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          // If onPressed is null, Flutter uses a disabled color automatically.
          // You can also define disabledBackgroundColor here if you want.
          backgroundColor: backgroundColor ?? AppColors.primaryOrange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        onPressed: onPressed, // Now accepts null correctly!
        child: Text(
          text.toUpperCase(),
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
            color: textColor,
          ),
        ),
      ),
    );
  }
}