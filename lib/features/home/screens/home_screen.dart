
import 'package:flutter/material.dart';
import '../widgets/home_header.dart';
import '../widgets/category_card.dart';
import '../widgets/deal_card.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: _buildBottomNav(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(userName: "ismail"),
              const SizedBox(height: 25),
              _buildPromoBanner(),
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
        DealCard(title: "Avocado", price: "\$6.7", imagePath: 'assets/images/avocado.png'),
        DealCard(title: "Brocoli", price: "\$8.7", imagePath: 'assets/images/broccoli.png'),
        DealCard(title: "Tomatoes", price: "\$4.9", imagePath: 'assets/images/tomatoes.png'),
        DealCard(title: "Grapes", price: "\$7.2", imagePath: 'assets/images/grapes.png'),
      ],
    );
  }

  Widget _buildMoreButton() {
    return SizedBox(
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

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.swap_horiz), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.shopping_cart_outlined), label: ""),
        BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ""),
        BottomNavigationBarItem(icon: CircleAvatar(radius: 12, backgroundImage: AssetImage('assets/images/profile.png')), label: ""),
      ],
    );
  }

  Widget _buildPromoBanner() {

    return Container(

      height: 180,

      width: double.infinity,

      decoration: BoxDecoration(

        borderRadius: BorderRadius.circular(20),

        image: const DecorationImage(

          image: AssetImage('assets/images/promo_banner.png'),

          fit: BoxFit.cover,

        ),

      ),

      child: Container(

        padding: const EdgeInsets.all(20),

        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(20),

          gradient: LinearGradient(

            colors: [Colors.black.withOpacity(0.6), Colors.transparent],

            begin: Alignment.bottomLeft,

          ),

        ),

        child: const Align(

          alignment: Alignment.bottomLeft,

          child: Text(

            "Recommended\nRecipe Today",

            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),

          ),

        ),

      ),

    );

  }
}