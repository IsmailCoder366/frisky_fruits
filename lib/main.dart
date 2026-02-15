import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// 👈 Add this import to handle Web-specific initialization
import 'package:flutter_stripe_web/flutter_stripe_web.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Bloc Imports
import 'core/navigation/bloc/navigation_bloc.dart';
import 'core/routes/app_pages.dart';
import 'core/routes/app_routes.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/auth_state.dart';
import 'features/onboarding/logic/onboarding_bloc.dart';
import 'features/products/bloc/cart_bloc/cart_bloc.dart';
import 'features/checkout/bloc/payment_bloc.dart';
import 'features/checkout/repository/payment_repository.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    // 1. Initialize Firebase
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await dotenv.load(fileName: ".env");
    // 2. Stripe Initialization (Web vs Mobile check)
    if (kIsWeb) {
      // 🚀 Using WebStripe prevents the Platform._operatingSystem exception
      WebStripe.instance.initialise(publishableKey: dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "");
    } else {
      Stripe.publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY'] ?? "";
      await Stripe.instance.applySettings();
    }

    runApp(const FriskyFruitsApp());
  } catch (e) {
    debugPrint("Critical Initialization Error: $e");
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Init Error: $e", textAlign: TextAlign.center),
            ),
          ),
        ),
      ),
    );
  }
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
        // Explicitly typed BLoC provider for better error handling
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<PaymentBloc>(
          create: (context) => PaymentBloc(PaymentRepository()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Frisky Fruits',
        initialRoute: Routes.splash,
        routes: AppPages.getPages(),
      ),
    );
  }
}