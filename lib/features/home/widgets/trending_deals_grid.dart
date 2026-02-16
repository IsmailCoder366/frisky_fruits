import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/navigation/bloc/navigation_bloc.dart';
import '../../../core/navigation/bloc/navigation_event.dart';
import 'deal_card.dart';

class TrendingDealsGrid extends StatelessWidget {
  const TrendingDealsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NavigationBloc>().add(TabChanged(2));
      },
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        children: [
          DealCard(
            title: "Avocado",
            price: "\$6.7",
            imagePath: 'assets/images/avocadro.png',

          ),
          DealCard(
            title: "Brocoli",
            price: "\$8.7",
            imagePath: 'assets/images/brocoli.png',

          ),
          DealCard(
            title: "Tomato",
            price: "\$4.9",
            imagePath: 'assets/images/tomato.png',

          ),
          DealCard(
            title: "Grapes",
            price: "\$7.2",
            imagePath: 'assets/images/grapes.png',

          ),
        ],
      ),
    );
  }
}
