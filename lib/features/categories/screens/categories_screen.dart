import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_event.dart';
import '../data/category_data.dart';
import '../widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int selectedIndex = -1;

  // This function contains the logic to wait, reset color, and navigate
  void handleSelection(int index) async {
    setState(() {
      selectedIndex = index;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      selectedIndex = -1;
    });

    if (mounted) {
      // This sends the command to RootScreen to change tabs
      context.read<NavigationBloc>().add(TabChanged(2));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Categories", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      // REMOVED the GestureDetector that was here
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 0.85,
        ),
        itemCount: CategoryData.categories.length,
        itemBuilder: (context, index) {
          return CategoryGridItem(
            category: CategoryData.categories[index],
            isSelected: selectedIndex == index,
            onTap: () {
              // FIX: Call the handleSelection function, not just setState
              handleSelection(index);
            },
          );
        },
      ),
    );
  }
}