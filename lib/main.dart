import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/navigation/bloc/navigation_bloc.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/onboarding/logic/onboarding_bloc.dart';
import 'features/products/bloc/cart_bloc/cart_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FriskyFruitsApp());

}

class FriskyFruitsApp extends StatelessWidget {
  const FriskyFruitsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => OnboardingBloc()),
        BlocProvider(create: (context) => NavigationBloc()),
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
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