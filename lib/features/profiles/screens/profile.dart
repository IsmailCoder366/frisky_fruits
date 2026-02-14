import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/routes/app_routes.dart';
import '../../auth/bloc/auth_bloc.dart';
import '../../auth/bloc/auth_event.dart';
import '../../auth/bloc/auth_state.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../repository/profile_repository.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Current user is needed for both the Firestore stream and the BLoC event
    final user = FirebaseAuth.instance.currentUser;

    return BlocProvider(
      create: (context) => ProfileBloc(ProfileRepository()),
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is Unauthenticated) {
                Navigator.pushNamedAndRemoveUntil(context, Routes.login, (route) => false);
              }
            },
          ),
          BlocListener<ProfileBloc, ProfileState>(
            listener: (context, state) {
              if (state is ProfilePicUploadFailure) {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.error),
                    backgroundColor: Colors.redAccent,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
              if (state is ProfilePicUploadSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Profile picture updated successfully!"),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
          ),
        ],
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, authState) {
            return BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, profileState) {
                return Stack(
                  children: [
                    Scaffold(
                      backgroundColor: Colors.white,
                      appBar: AppBar(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        centerTitle: true,
                        title: const Text("Profile",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                      ),
                      body: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20),

                            /// --- Profile Header (Dynamic) ---
                            StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user?.uid)
                                  .snapshots(),
                              builder: (context, snapshot) {
                                String name = "Loading...";
                                String email = user?.email ?? "No Email";
                                String? profileUrl;

                                if (snapshot.hasData && snapshot.data!.exists) {
                                  final data = snapshot.data!.data() as Map<String, dynamic>;
                                  name = data['name'] ?? "User";
                                  profileUrl = data['profilePic']; // Cloudinary URL from Firestore
                                }

                                return Column(
                                  children: [
                                    Stack(
                                      alignment: Alignment.bottomRight,
                                      children: [
                                        CircleAvatar(
                                          radius: 60,
                                          backgroundColor: Colors.grey[100],
                                          // Priority: 1. Cloudinary URL, 2. Default Asset
                                          backgroundImage: profileUrl != null && profileUrl.isNotEmpty
                                              ? NetworkImage(profileUrl)
                                              : const AssetImage('assets/images/profile_pic.png') as ImageProvider,
                                        ),

                                        // Camera Icon / Uploading Spinner
                                        GestureDetector(
                                          onTap: profileState is ProfilePicUploading
                                              ? null
                                              : () {
                                            if (user != null) {
                                              context.read<ProfileBloc>().add(
                                                  UpdateProfilePicRequested(user.uid)
                                              );
                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: const Color(0xFFF2994A),
                                              shape: BoxShape.circle,
                                              border: Border.all(color: Colors.white, width: 3),
                                            ),
                                            child: profileState is ProfilePicUploading
                                                ? const SizedBox(
                                              width: 18,
                                              height: 18,
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                color: Colors.white,
                                              ),
                                            )
                                                : const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                                    Text(email, style: const TextStyle(color: Colors.grey, fontSize: 14)),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 30),

                            /// --- Menu Options ---
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
                                    Icons.logout,
                                    "Logout",
                                    authState is AuthLoading
                                        ? () {}
                                        : () {
                                      context.read<AuthBloc>().add(SignOutRequested());
                                      // Navigator is already handled by BlocListener above
                                    },
                                    textColor: Colors.red,
                                    iconColor: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// Global Loading Overlay
                    if (authState is AuthLoading)
                      Container(
                        color: Colors.black.withOpacity(0.3),
                        child: const Center(child: CircularProgressIndicator(color: Color(0xFFF2994A))),
                      ),
                  ],
                );
              },
            );
          },
        ),
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