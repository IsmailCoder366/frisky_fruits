import 'package:flutter/material.dart';
import 'onboarding_routes.dart';
import 'auth_routes.dart';

class AppRouter {
  static Map<String, WidgetBuilder> allRoutes = {
    ...OnboardingRoutes.getRoutes(),
    ...AuthRoutes.getRoutes(),
    // Add more feature routes here as you build them (e.g., ...HomeRoutes.getRoutes())
  };
}