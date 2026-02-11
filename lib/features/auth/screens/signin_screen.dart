import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/frisky_button.dart';
import '../../../core/widgets/frisky_textfield.dart';
import '../bloc/auth_bloc.dart'; // Import your AuthBloc
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';

class SigninScreen extends StatefulWidget { // Changed to StatefulWidget for controllers
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  // 1. Controllers and Form Key
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
            Navigator.pushReplacementNamed(context, Routes.rootScreen);
          } else if (state is AuthError) {

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.red),
            );
          }
        },
        child: Stack(
          children: [
            /// Background Image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.45,
              child: Image.asset(
                'assets/images/signin_img.png',
                fit: BoxFit.cover,
              ),
            ),

            /// Bottom Container
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
                  child: Form( // 3. Wrap with Form
                    key: _formKey,
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
                                onPressed: () => Navigator.pop(context),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30),

                        // 4. Email Field with Validation
                        FriskyTextField(
                          controller: _emailController,
                          hintText: "Email address",
                          keyboardType: TextInputType.emailAddress,
                          validator: AppValidations.validateEmail,
                        ),
                        const SizedBox(height: 15),

                        // 5. Password Field with Validation
                        FriskyTextField(
                          controller: _passwordController,
                          hintText: "Password",
                          isPassword: true,
                          validator: AppValidations.validatePassword,
                        ),
                        const SizedBox(height: 10),

                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text('Forgot Password?',
                                style: TextStyle(color: AppColors.orangeText, fontWeight: FontWeight.w600)),
                          ),
                        ),
                        const SizedBox(height: 30),

                        // 6. BlocBuilder for the Button State
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthLoading) {
                              return const Center(child: CircularProgressIndicator());
                            }
                            return FriskyButton(
                              textColor: Colors.black,
                              text: "SIGN IN",
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Trigger the BLoC event
                                  context.read<AuthBloc>().add(
                                    SignInRequested(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    ),
                                  );
                                }
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Don't have an account? "),
                            InkWell(
                              onTap: () => Navigator.pushNamed(context, '/signup'),
                              child: const Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold)),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}