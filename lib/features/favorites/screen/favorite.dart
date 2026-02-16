import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../home/bloc/favorite_bloc.dart';
import '../../home/bloc/favorite_event.dart';
import '../../home/bloc/favorite_state.dart';


class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        // 1. Use BlocBuilder to listen to changes in the favorite list
        child: BlocBuilder<FavoritesBloc, FavoritesState>(
          builder: (context, state) {
            // Logic: Show a placeholder if the list is empty
            if (state.favoriteItems.isEmpty) {
              return const Center(
                child: Text("Your favorite list is empty!"),
              );
            }

            return GridView.builder(
              itemCount: state.favoriteItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemBuilder: (context, index) {
                // Logic: Get the specific product data for this card
                final product = state.favoriteItems[index];
                return _buildFavoriteItem(context, product);
              },
            );
          },
        ),
      ),
    );
  }

  // 2. Pass the product Map into the builder
  Widget _buildFavoriteItem(BuildContext context, Map<String, String> product) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    product['imagePath'] ?? 'assets/images/placeholder.png',
                    height: 180,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'] ?? "Unknown",
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const Text(
                      "1kg, Price",
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product['price'] ?? "\$0.00",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFFF2994A)),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFFFCC4D),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: GestureDetector(
              onTap: () {
                // Logic: Remove from favorites using the same Toggle event
                context.read<FavoritesBloc>().add(ToggleFavorite(product));
              },
              child: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}