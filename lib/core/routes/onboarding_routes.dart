import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/onboarding/logic/onboarding_bloc.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import '../../features/splash/screens/splash_screen.dart';

class OnboardingRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const SplashScreen(),
      '/onboarding': (context) => BlocProvider(
        create: (context) => OnboardingBloc(),
        child: const OnboardingScreen(),
      ),
    };
  }
}