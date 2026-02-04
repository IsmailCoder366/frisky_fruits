import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class FriskyTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType keyboardType;

  const FriskyTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    this.controller,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<FriskyTextField> createState() => _FriskyTextFieldState();
}

class _FriskyTextFieldState extends State<FriskyTextField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _obscureText : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        // Orange Border Style from Image
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: AppColors.primaryOrange.withOpacity(0.5),
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.primaryOrange, width: 2),
        ),
        // Password Eye Icon
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: Colors.grey,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        )
            : null,
      ),
    );
  }
}