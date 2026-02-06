import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/widgets/frisky_button.dart';
import '../../../core/widgets/frisky_textfield.dart';
import '../widgets/congratulations_dialog.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

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
              'assets/images/signin_img.png', // Add your fruit image here
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
                          "Sign In",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.black,
                          radius: 15,
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.close, color: Colors.white, size: 18),
                            onPressed: () {},
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),

                    const FriskyTextField(
                      hintText: "Email address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 15),
                    const FriskyTextField(
                      hintText: "Password",
                      isPassword: true,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: InkWell(
                            onTap: (){},
                              child: Text('Forgot Password?', style: TextStyle(color: AppColors.orangeText),)),
                        )
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Main Create Account Button
                    // Update the FriskyButton onPressed in your SignupScreen
                    FriskyButton(
                      textColor: Colors.black,
                      text: "SIGN IN",
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.rootScreen);
                      },
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?"),
                        InkWell(
                          onTap: (){
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text('signup'),
                        )
                      ],
                    )
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