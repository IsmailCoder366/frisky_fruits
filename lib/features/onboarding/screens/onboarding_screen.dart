import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/frisky_button.dart';
import '../logic/onboarding_bloc.dart';
import '../logic/onboarding_event.dart';
import '../logic/onboarding_state.dart';
import '../widgets/onboarding_body.dart';
import '../widgets/onboarding_dot.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            elevation: 0,
            // 1. DYNAMIC BACK BUTTON: Only show if NOT on the first page
            leading: state.currentIndex > 0
                ? IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryOrange),
              onPressed: () {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              },
            )
                : null,
            actions: [
              // 2. SKIP BUTTON: Show only on the first page (index 0)
              if (state.currentIndex == 0)
                TextButton(
                  onPressed: () {
                    // Skip directly to Login
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(
                      color: AppColors.primaryOrange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) =>
                      context.read<OnboardingBloc>().add(PageChanged(index)),
                  children: const [
                    OnboardingBody(
                      image: 'assets/images/onboarding1.png',
                      title: 'Welcome to Fresh Fruits\nGrocery application',
                      description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
                    ),
                    OnboardingBody(
                      image: 'assets/images/onboarding2.png',
                      title: 'We provide best quality\nFruits to your family',
                      description: 'Fresh fruits delivered to your home within 30 minutes.',
                    ),
                    OnboardingBody(
                      image: 'assets/images/onboarding3.png',
                      title: 'Fast and responsibily\ndelivery by our courir ',
                      description: 'Integrated with Stripe for a frisky shopping experience.',
                    ),
                  ],
                ),
              ),

              // Dot Indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(3, (index) =>
                    OnboardingDot(index: index, currentIndex: state.currentIndex)
                ),
              ),

              const SizedBox(height: 40),

              // Next Button
              // Inside lib/features/onboarding/screens/onboarding_screen.dart

              // Inside lib/features/onboarding/screens/onboarding_screen.dart

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: state.currentIndex == 2
                    ? Column(
                  children: [
                    // 1. Create Account Button (Solid Black as per image)
                    FriskyButton(
                      text: "Create an account",
                      backgroundColor: Colors.black,
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/signup');
                      },
                      textColor: state.currentIndex == 2
                        ? Colors.white : Colors.black
                    ),
                    const SizedBox(height: 16),
                    // 2. Login Button (White with Black Border as per image)
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.black, width: 2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/login');
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
                    : FriskyButton(
                  textColor: Colors.black,
                  text: "Next",
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}