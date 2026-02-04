import 'package:flutter/material.dart';

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
              _buildHeader(),
              const SizedBox(height: 25),
              _buildPromoBanner(),
              const SizedBox(height: 25),
              _buildSectionHeader("Categories"),
              _buildCategories(),
              const SizedBox(height: 25),
              _buildSectionHeader("Trending Deals"),
              _buildTrendingDeals(),
              const SizedBox(height: 20),
              _buildMoreButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Good Morning", style: TextStyle(color: Colors.grey, fontSize: 16)),
            Text("ismail", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
        const Icon(Icons.notifications_none_outlined, size: 28),
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

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Icon(Icons.arrow_forward),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _categoryItem(Icons.apple_outlined),
          _categoryItem(Icons.bakery_dining_outlined),
          _categoryItem(Icons.local_drink_outlined),
          _categoryItem(Icons.rice_bowl_outlined),
        ],
      ),
    );
  }

  Widget _categoryItem(IconData icon) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 2)],
      ),
      child: Icon(icon, color: Colors.purple, size: 30),
    );
  }

  Widget _buildTrendingDeals() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        _dealItem("Avocado", "\$6.7", 'assets/images/avocado.png'),
        _dealItem("Brocoli", "\$8.7", 'assets/images/broccoli.png'),
        _dealItem("Tomatoes", "\$4.9", 'assets/images/tomatoes.png'),
        _dealItem("Grapes", "\$7.2", 'assets/images/grapes.png'),
      ],
    );
  }

  Widget _dealItem(String title, String price, String img) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(image: AssetImage(img), fit: BoxFit.cover),
      ),
      child: Stack(
        children: [
          Positioned(top: 10, left: 10, child: Icon(Icons.favorite, color: Colors.red.shade400)),
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                Text(price, style: const TextStyle(color: Colors.white)),
              ],
            ),
          )
        ],
      ),
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
}