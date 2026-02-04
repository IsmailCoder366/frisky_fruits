// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/onboarding/logic/onboarding_bloc.dart';
import 'features/splash/screens/splash_screen.dart';
import 'features/onboarding/screens/onboarding_screen.dart';

void main() {
  runApp(const FriskyFruitsApp());
}

class FriskyFruitsApp extends StatelessWidget {
  const FriskyFruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        // WRAP THE SCREEN HERE
        '/onboarding': (context) => BlocProvider(
          create: (context) => OnboardingBloc(),
          child: const OnboardingScreen(),
        ),
      },
    );
  }
}