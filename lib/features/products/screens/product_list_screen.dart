import 'package:flutter/material.dart';
import '../widgets/product_grid_item.dart';
import '../models/product_model.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for display
    final List<ProductModel> products = [
      const ProductModel(name: "Avocado", price: "\$6.7", imagePath: 'assets/images/avocadro.png', isFavorite: true),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/sugar_free.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/orange.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/banana.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/tomatoes.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/grapes_juice.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/avocado.png'),
      const ProductModel(name: "Blueberry", price: "\$8.7", imagePath: 'assets/images/blueberry.png'),

    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      body: Column(
        children: [
          // Yellow Header Section
          Container(
            padding: const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 30),
            decoration: const BoxDecoration(
              color: Color(0xFFFFCC4D), // Matches Deals.jpg yellow
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back, color: Colors.white),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.tune, color: Colors.white)),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Fruits Category", style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("87 Items", style: TextStyle(color: Colors.white70, fontSize: 14)),
              ],
            ),
          ),
          // Search Bar & Grid
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Search here",
                      prefixIcon: const Icon(Icons.search),
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                    ),
                  ),
                  const SizedBox(height: 20),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      childAspectRatio: 0.75,
                    ),
                    itemCount: products.length,
                    itemBuilder: (context, index) => ProductGridItem(product: products[index]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}