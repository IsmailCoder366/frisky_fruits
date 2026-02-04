import 'package:flutter/material.dart';
import 'core/routes/app_router.dart';

void main() {
  runApp(const FriskyFruitsApp());
}

class FriskyFruitsApp extends StatelessWidget {
  const FriskyFruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Frisky Fruits',
      initialRoute: '/',
      // We call the combined map here
      routes: AppRouter.allRoutes,
    );
  }
}