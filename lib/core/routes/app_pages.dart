import 'package:flutter/material.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';

import 'app_routes.dart';

class AppPages {
  // This map is what the MaterialApp 'routes' property expects
  static Map<String, WidgetBuilder> getPages() {
    return {
      Routes.splash: (context) => const SplashScreen(),
      Routes.onboarding: (context) => const OnboardingScreen(),
      // Routes.login: (context) => const LoginScreen(),
      Routes.signup: (context) => const SignupScreen(),

      // Placeholders for your two modules
      // Routes.userHome: (context) => const UserHomeScreen(),
      // Routes.creatorMain: (context) => const CreatorMainView(),
    };
  }
}