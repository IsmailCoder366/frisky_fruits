import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frisky_fruits/features/home/bloc/favorite_event.dart';
import 'package:http/http.dart';

import '../bloc/favorite_bloc.dart';
import '../bloc/favorite_state.dart';

class DealCard extends StatelessWidget {
  final String title;
  final String price;
  final String imagePath;


  const DealCard({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,

  });

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        // ISSUE 1 FIXED: Use the boolean logic to decide the icon and color
        // We check if this specific product's title exists in the Bloc's state list
        bool isFavorite = state.favoriteItems.any((item) => item['title'] == title);

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // ISSUE 2 FIXED: Ensure imagePath is passed correctly
            image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                left: 10,
                child: GestureDetector(
                  onTap: () {
                    // ISSUE 3 FIXED: Construct the 'product' map correctly for the Bloc event
                    final product = {
                      'title': title,
                      'price': price,
                      'imagePath': imagePath,
                    };

                    // 1. Update the BLoC (The Data)
                    context.read<FavoritesBloc>().add(ToggleFavorite(product));


                  },
                  child: Icon(
                    // Logic: Show solid heart if favorite, border heart if not
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red.shade400 : Colors.white,
                    size: 28,
                  ),
                ),
              ),
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
      },
    );
  }
}