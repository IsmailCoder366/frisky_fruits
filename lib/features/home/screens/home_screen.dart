
import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/category_card.dart';
import '../widgets/deal_card.dart';
import '../widgets/promo_slider.dart';
import '../widgets/section_header.dart';

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
              const SectionHeader(title: "Categories"),
              _buildCategoryList(),
              const SizedBox(height: 25),
              const SectionHeader(title: "Trending Deals"),
              _buildDealsGrid(),
              const SizedBox(height: 20),
              _buildMoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryCard(icon: Icons.apple_outlined),
          CategoryCard(icon: Icons.bakery_dining_outlined),
          CategoryCard(icon: Icons.local_drink_outlined),
          CategoryCard(icon: Icons.rice_bowl_outlined),
        ],
      ),
    );
  }

  Widget _buildDealsGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: const [
        DealCard(title: "Avocado", price: "\$6.7", imagePath: 'assets/images/avocadro.png'),
        DealCard(title: "Brocoli", price: "\$8.7", imagePath: 'assets/images/brocoli.png'),
        DealCard(title: "Tomato", price: "\$4.9", imagePath: 'assets/images/tomato.png'),
        DealCard(title: "Grapes", price: "\$7.2", imagePath: 'assets/images/grapes.png'),
      ],
    );
  }

  Widget _buildMoreButton() {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        onPressed: () {},
        child: const Text("More", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }

}