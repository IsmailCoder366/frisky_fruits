import 'package:flutter/material.dart';

class DetailsImageHeader extends StatelessWidget {
  final List<String> images;

  const DetailsImageHeader({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Stack(
        children: [
          PageView.builder(
            itemCount: images.length,
            itemBuilder: (context, index) => Image.asset(images[index], fit: BoxFit.cover),
          ),
          // Pill Indicators
          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: index == 2 ? 30 : 20,
                height: 5,
                decoration: BoxDecoration(
                  color: index == 2 ? Colors.white : Colors.white54,
                  borderRadius: BorderRadius.circular(10),
                ),
              )),
            ),
          ),
          // Actions
          Positioned(
            top: 50,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 28),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Positioned(
            top: 50,
            right: 20,
            child: IconButton(
              icon: const Icon(Icons.share_outlined, color: Colors.white, size: 28),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}