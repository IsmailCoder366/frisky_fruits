import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frisky_fruits/features/profiles/screens/profile.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_state.dart';
import '../../../core/navigation/bloc/navigation_event.dart';
import '../../favorites/screen/favorite.dart';
import '../../home/screens/home_screen.dart';
import '../../categories/screens/categories_screen.dart';
import '../../products/screens/product_list_screen.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of screens corresponding to bottom nav indices
    final List<Widget> pages = [
      const HomeScreen(),
      const CategoriesScreen(), // Index 1 from your image
      const ProductListScreen(),
      const FavoritesScreen(),
      const ProfileScreen()
    ];

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          body: IndexedStack(
            index: state.currentIndex,
            children: pages,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: state.currentIndex,
            onTap: (index) => context.read<NavigationBloc>().add(TabChanged(index)),
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.orangeText,
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: ""),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: ""),
              BottomNavigationBarItem(icon: CircleAvatar(radius: 12), label: ""),
            ],
          ),
        );
      },
    );
  }
}