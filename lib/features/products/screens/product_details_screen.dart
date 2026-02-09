import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Assuming these paths are correct for your project structure
import '../bloc/product_bloc/product_bloc.dart';
import '../bloc/product_bloc/product_event.dart';
import '../bloc/product_bloc/product_state.dart';
import '../models/product_model.dart';
import '../widgets/details_bottom_action.dart';
import '../widgets/details_image_header.dart';
import '../widgets/rating_row.dart';
import '../widgets/product_tabs.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)!.settings.arguments;
    if (args == null || args is! ProductModel) {
      return const Scaffold(
        body: Center(child: Text("No product data found. Please go back.")),
      );
    }
    final product = args;
    final double rawPrice = double.tryParse(product.price.replaceAll('\$', '')) ?? 0.0;

    return BlocProvider(
      create: (context) => ProductBloc()
        ..add(InitializeProduct(
          basePrice: rawPrice,
          initialTabIndex: 0,
        )),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                // ONE SLIVER: Handles the Image and the Rounded Overlap
                SliverToBoxAdapter(
                  child: Stack(
                    children: [
                      // LAYER 1: The Product Image
                      // We give it a slightly larger height to ensure it fits behind the rounds
                      DetailsImageHeader(images: [product.imagePath]),

                      // LAYER 2: The White Rounded Info Box
                      // We use Padding to push it down so the image shows above it.
                      // The borderRadius here will show the image through the corners.
                      Padding(
                        padding: const EdgeInsets.only(top: 280), // Adjust this value to show more/less image
                        child: _buildProductHeaderInfo(context, product),
                      ),
                    ],
                  ),
                ),

                // STICKY TABS: Kept as a separate sliver to use "pinned: true"
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _SliverAppBarDelegate(
                    const PreferredSize(
                      preferredSize: Size.fromHeight(50),
                      child: ProductTabs(),
                    ),
                  ),
                ),
              ];
            },
            body: TabBarView(
              children: [
                _TabContent(
                    key: const PageStorageKey('description'),
                    text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam at porttitor sem.  Aliquam erat volutpat. Donec placerat nisl magna, et faucibus arcu condimentum sed."
                ),
                const _TabContent(key: PageStorageKey('reviews'), text: "No reviews yet for this fruit."),
                 _TabContent(key: PageStorageKey('discussion'), text: "Join the conversation about ${product.name}."),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(25, 0, 25, 30),
                child: DetailsBottomActions(
                  product: product,
                  price: "\$${state.totalPrice.toStringAsFixed(1)}",
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeaderInfo(BuildContext context, ProductModel product) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            // THE FIX: These corners now sit directly on top of the Stack's image layer
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(25, 30, 25, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                    "FRUITS",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 13)
                ),
                Text(
                    product.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        "\$${state.totalPrice.toStringAsFixed(1)}",
                        style: const TextStyle(
                            fontSize: 26,
                            color: Color(0xFFFFCC4D),
                            fontWeight: FontWeight.bold
                        )
                    ),
                    _buildQuantitySelector(context, state.quantity),
                  ],
                ),
                const SizedBox(height: 20),
                const RatingRow(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuantitySelector(BuildContext context, int quantity) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.read<ProductBloc>().add(DecrementQuantity()),
            icon: const Icon(Icons.remove, color: Color(0xFFFFCC4D)),
          ),
          Text(
              "$quantity",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
          ),
          IconButton(
            onPressed: () => context.read<ProductBloc>().add(IncrementQuantity()),
            icon: const Icon(Icons.add, color: Color(0xFFFFCC4D)),
          ),
        ],
      ),
    );
  }
}

// Delegate for the Pinned TabBar
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);
  final PreferredSize _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      height: _tabBar.preferredSize.height,
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) => false;
}

// Tab Content Widget
class _TabContent extends StatelessWidget {
  final String text;
  const _TabContent({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      children: [
        Text(
            text,
            style: const TextStyle(color: Colors.black54, height: 1.6, fontSize: 15)
        ),
        const SizedBox(height: 100), // Extra space for scrolling visibility
      ],
    );
  }
}