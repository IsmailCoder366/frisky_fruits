import 'package:flutter/material.dart';
import 'package:frisky_fruits/features/auth/screens/signin_screen.dart';
import 'package:frisky_fruits/features/checkout/screen/checkout_screen.dart';
import 'package:frisky_fruits/features/checkout/screen/order_success.dart';
import 'package:frisky_fruits/features/checkout/screen/order_tracking_screen.dart';
import 'package:frisky_fruits/features/checkout/screen/payment_method_screen.dart';
import 'package:frisky_fruits/features/checkout/screen/write_review.dart';
import 'package:frisky_fruits/features/products/screens/cart_screen.dart';
import 'package:frisky_fruits/features/root/screens/root_screen.dart';
import '../../features/auth/screens/signup_screen.dart';
import '../../features/home/screens/home_screen.dart';
import '../../features/products/screens/product_details_screen.dart';
import '../../features/splash/screens/splash_screen.dart';
import '../../features/onboarding/screens/onboarding_screen.dart';
import 'app_routes.dart';

class AppPages {
  // This map is what the MaterialApp 'routes' property expects
  static Map<String, WidgetBuilder> getPages() {
    return {
      Routes.splash: (context) => const SplashScreen(),
      Routes.onboarding: (context) => const OnboardingScreen(),
      Routes.login: (context) => const SigninScreen(),
      Routes.signup: (context) => const SignupScreen(),
      Routes.home: (context) => const HomeScreen(),
      Routes.rootScreen: (context) => const RootScreen(),
      Routes.productDetails: (context) => const ProductDetailsScreen(),
      Routes.cartScreen: (context) => const CartScreen(),
      Routes.checkout: (context) => const CheckoutScreen(),
      Routes.paymentMethod: (context) => const PaymentMethodScreen(),
      Routes.orderSuccess: (context) => const OrderSuccessScreen(),
      Routes.orderTracking: (context) => const OrderTrackingScreen(),
      Routes.writeReview: (context) => const WriteReviewScreen(),

      // Placeholders for your two modules
      // Routes.userHome: (context) => const UserHomeScreen(),
      // Routes.creatorMain: (context) => const CreatorMainView(),
    };
  }
}