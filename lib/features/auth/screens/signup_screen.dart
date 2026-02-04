import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/frisky_button.dart';
import '../../../core/widgets/frisky_textfield.dart';
import '../widgets/congratulations_dialog.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          /// 1. Background Image (Fruits)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Image.asset(
              'assets/images/signup_img.png', // Add your fruit image here
              fit: BoxFit.cover,
            ),
          ),

          /// 2. Container
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: MediaQuery.of(context).size.height * 0.65,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Create your account",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // First & Last Name Row
                    Row(
                      children: const [
                        Expanded(
                          child: FriskyTextField(hintText: "First Name"),
                        ),
                        SizedBox(width: 15),
                        Expanded(child: FriskyTextField(hintText: "Last Name")),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const FriskyTextField(
                      hintText: "Email address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    const FriskyTextField(
                      hintText: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),

                    // Terms and Conditions Text
                    Center(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "By tapping Sign up you accept all\n",
                            ),
                            TextSpan(
                              text: "terms ",
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: "and "),
                            TextSpan(
                              text: "condition",
                              style: TextStyle(
                                color: AppColors.primaryOrange,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Main Create Account Button
                    // Update the FriskyButton onPressed in your SignupScreen
                    FriskyButton(
                      textColor: Colors.black,
                      text: "Create an account",
                      onPressed: () {
                        // 1. In a real app, you'd call your LoginBloc/AuthBloc here
                        // 2. Show the pop-up on success
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          // User must click "Sign In"
                          builder: (context) => CongratulationsDialog(
                            userName: "ismail",
                            // This would come from your controllers
                            onSignIn: () {
                              Navigator.pushReplacementNamed(
                                context,
                                Routes.login,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/signin');
                          },
                          child: Text('signin'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
