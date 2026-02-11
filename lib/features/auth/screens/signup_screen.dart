import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/frisky_button.dart';
import '../../../core/widgets/frisky_textfield.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widgets/congratulations_dialog.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
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
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => CongratulationsDialog(
                userName: _firstNameController.text.trim(),
                onSignIn: () {
                  Navigator.pop(context);
                  Navigator.pushReplacementNamed(context, Routes.login);
                },
              ),
            );
          } else if (state is AuthError) {
            // 👈 1. Clear existing snackbars to prevent double pop-ups
            ScaffoldMessenger.of(context).hideCurrentSnackBar();

            // 👈 2. Show the fresh error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.redAccent,
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(20),
                duration: const Duration(seconds: 2), // Keep it concise
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return Stack(
              children: [
                /// 1. Background Image
                Positioned(
                  top: 0, left: 0, right: 0,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: Image.asset('assets/images/signup_img.png', fit: BoxFit.cover),
                ),

                /// 2. Bottom Form Container
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
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Create your account",
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
                                ),
                              ],
                            ),
                            const SizedBox(height: 30),

                            // Name Fields
                            Row(
                              children: [
                                Expanded(
                                  child: FriskyTextField(
                                    controller: _firstNameController,
                                    hintText: "First Name",
                                    validator: (val) => val!.isEmpty ? 'Required' : null,
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: FriskyTextField(
                                    controller: _lastNameController,
                                    hintText: "Last Name",
                                    validator: (val) => val!.isEmpty ? 'Required' : null,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),

                            // Email & Password
                            FriskyTextField(
                              controller: _emailController,
                              hintText: "Email address",
                              keyboardType: TextInputType.emailAddress,
                              validator: AppValidations.validateEmail,
                            ),
                            const SizedBox(height: 15),
                            FriskyTextField(
                              controller: _passwordController,
                              hintText: "Password",
                              isPassword: true,
                              validator: AppValidations.validatePassword,
                            ),
                            const SizedBox(height: 20),

                            const Center(
                              child: Text("By tapping Sign up you accept all terms and conditions",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 12, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(height: 30),

                            /// 3. Sign Up Button
                            FriskyButton(
                              text: "Create an account",
                              textColor: Colors.black,
                              onPressed: state is AuthLoading
                                  ? () {}
                                  : () {
                                if (_formKey.currentState!.validate()) {
                                  final fullName = "${_firstNameController.text.trim()} ${_lastNameController.text.trim()}";
                                  context.read<AuthBloc>().add(
                                    SignUpRequested(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                      name: fullName,
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 30),

                            // Switch to Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Already have an account? "),
                                InkWell(
                                  onTap: () => Navigator.pushNamed(context, Routes.login),
                                  child: const Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                /// 4. Loading Overlay
                if (state is AuthLoading)
                  Container(
                    color: Colors.black12,
                    child: const Center(child: CircularProgressIndicator(color: Colors.orange)),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}