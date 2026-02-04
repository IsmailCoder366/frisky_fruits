import 'dart:async'; // Required for Timer
import 'package:flutter/material.dart';
import 'package:frisky_fruits/core/constants/app_colors.dart';

import '../../onboarding/screens/onboarding_screen.dart';
// Import your next screen here, e.g.:
// import '../../onboarding/screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      // Navigate using the route name we defined in main.dart
      Navigator.pushReplacementNamed(context, '/onboarding');
      print("Navigated to Onboarding");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Corrected from primaryOrange to accentOrange based on your AppColors file
      backgroundColor: AppColors.primaryOrange,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Fixed syntax error
          children: [
            // 2. Added a Hero widget for a smooth transition later
            const Hero(
              tag: 'app_logo',
              child: Image(
                height: 250,
                image: AssetImage('assets/images/splash_image.png'),
              ),
            ),
            const SizedBox(height: 20), // Added spacing between image and text
            const Text(
              'Frisky Fruits',
              style: TextStyle(
                color: Colors.white,
                fontSize: 32, // Slightly increased for impact
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 50),

            const CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
