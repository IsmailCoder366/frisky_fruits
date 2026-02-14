import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frisky_fruits/features/profiles/screens/profile.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_event.dart';
import '../../../core/navigation/bloc/navigation_state.dart';

import '../../favorites/screen/favorite.dart';
import '../../home/screens/home_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../products/screens/product_list_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    final List<Widget> pages = [
      const HomeScreen(),
      const CategoriesScreen(),
      const ProductListScreen(),
      const FavoritesScreen(),
      const ProfileScreen()
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, navState) {
        return Scaffold(
          body: IndexedStack(
            index: navState.currentIndex,
            children: pages,
          ),
          bottomNavigationBar: StreamBuilder<DocumentSnapshot>(
            // Listens directly to Firestore for the profilePic field
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(user?.uid)
                .snapshots(),
            builder: (context, snapshot) {
              String? profileUrl;

              if (snapshot.hasData && snapshot.data!.exists) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                profileUrl = data['profilePic'];
              }

              return BottomNavigationBar(
                currentIndex: navState.currentIndex,
                onTap: (index) =>
                    context.read<NavigationBloc>().add(TabChanged(index)),
                type: BottomNavigationBarType.fixed,
                selectedItemColor: AppColors.orangeText,
                unselectedItemColor: Colors.grey,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  const BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
                  const BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ""),
                  const BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
                  const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
                  BottomNavigationBarItem(
                    icon: _buildDynamicAvatar(
                        profileUrl,
                        navState.currentIndex == 4 // Active check for index 4
                    ),
                    label: "",
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Helper to build the avatar with a selection ring
  Widget _buildDynamicAvatar(String? url, bool isActive) {
    return Container(
      padding: const EdgeInsets.all(2), // Space for the selection ring
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isActive ? AppColors.orangeText : Colors.transparent,
          width: 2,
        ),
      ),
      child: CircleAvatar(
        radius: 12,
        backgroundColor: Colors.grey[200],
        backgroundImage: (url != null && url.isNotEmpty)
            ? NetworkImage(url)
            : const AssetImage('assets/images/profile_pic.png') as ImageProvider,
      ),
    );
  }
}