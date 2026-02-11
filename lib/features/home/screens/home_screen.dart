import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_event.dart';
import '../widgets/home_header.dart';
import '../widgets/promo_slider.dart';
import '../widgets/section_header.dart';
import '../widgets/home_category_list.dart';
import '../widgets/trending_deals_grid.dart';
import '../widgets/home_more_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(userName: "ismail"),
              const SizedBox(height: 25),

              PromoSlider(
                images: const [
                  'assets/images/promo_banner_1.png',
                  'assets/images/promo_banner_2.png',
                  'assets/images/promo_banner_3.png',
                ],
                titles: const [
                  "Recommended\nRecipe Today",
                  "Fresh Fruit\nDiscounts",
                  "Healthy Living\nTips",
                ],
              ),

              const SizedBox(height: 25),
              SectionHeader(
                title: "Categories",
                onActionPressed: () => context.read<NavigationBloc>().add(TabChanged(1)),
              ),
              const SizedBox(height: 5),
              const HomeCategoryList(), // Very clean!

              const SizedBox(height: 25),
              SectionHeader(
                title: "Trending Deals",
                onActionPressed: () => context.read<NavigationBloc>().add(TabChanged(1)),
              ),
              const SizedBox(height: 5),
              const TrendingDealsGrid(), // Very clean!

              const SizedBox(height: 20),
              HomeMoreButton(onPressed: () {
                context.read<NavigationBloc>().add(TabChanged(2));
              }),
            ],
          ),
        ),
      ),
    );
  }
}