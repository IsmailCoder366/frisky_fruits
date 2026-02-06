import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_event.dart';

class CategoryCard extends StatelessWidget {

  final String images;
  const CategoryCard({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationBloc>().add(TabChanged(1));
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 15, top: 10, bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.grey.shade200, blurRadius: 5, spreadRadius: 2)],
        ),
        child: Image(image: AssetImage(images))
      ),
    );
  }
}