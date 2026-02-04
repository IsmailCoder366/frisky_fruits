import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'features/onboarding/logic/onboarding_bloc.dart';


void main() {
  runApp(const FriskyFruitsApp());
}

class FriskyFruitsApp extends StatelessWidget {
  const FriskyFruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Global BLoCs available to all 160 pages
        BlocProvider(create: (context) => OnboardingBloc()),
        // BlocProvider(create: (context) => LoginBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Frisky Fruits',
        initialRoute: Routes.splash,
        // Native Flutter routing table
        routes: AppPages.getPages(),
      ),
    );
  }
}