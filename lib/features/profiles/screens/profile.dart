import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is Unauthenticated) {
          Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final user = FirebaseAuth.instance.currentUser;
          return Stack(
            children: [
              Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  centerTitle: true,
                  title: const Text("Profile", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // Profile Header with Firestore Data

                      StreamBuilder<DocumentSnapshot>(
                        stream: FirebaseFirestore.instance.collection('users').doc(user?.uid).snapshots(),
                        builder: (context, snapshot) {
                          // 1. Default values while loading or if data is missing
                          String name = "Loading...";
                          String email = user?.email ?? "No Email";

                          if (snapshot.hasData && snapshot.data!.exists) {
                            final data = snapshot.data!.data() as Map<String, dynamic>;
                            // 2. Fetch the name we saved during SignUpRequested
                            name = data['name'] ?? "User";
                          }

                          return Column(
                            children: [
                              const CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage('assets/images/profile_pic.png'),
                              ),
                              const SizedBox(height: 15),
                              Text(
                                name, // 👈 This will now update as soon as Firestore responds
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                email,
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 30),

                      // Menu Options (UI preserved exactly as requested)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            _buildProfileTile(Icons.shopping_bag_outlined, "My Orders", () {}),
                            _buildProfileTile(Icons.favorite_border, "Favorites", () {}),
                            _buildProfileTile(Icons.location_on_outlined, "Shipping Address", () {}),
                            _buildProfileTile(Icons.payment_outlined, "Payment Methods", () {}),
                            const Divider(),
                            _buildProfileTile(
                              Icons.logout, "Logout",
                              state is AuthLoading ? () {}
                                  : () {
                                context.read<AuthBloc>().add(SignOutRequested());
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  Routes.login,
                                      (route) => false,
                                );
                              },


                              textColor: Colors.red, iconColor: Colors.red,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (state is AuthLoading)
                Container(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator(color: Color(0xFFF2994A))),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildProfileTile(IconData icon, String title, VoidCallback onTap, {Color? textColor, Color? iconColor}) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: (iconColor ?? const Color(0xFFF2994A)).withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: iconColor ?? const Color(0xFFF2994A)),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, color: textColor ?? Colors.black)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }
}

