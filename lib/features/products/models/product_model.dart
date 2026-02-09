class ProductModel {
  final String name;
  final String price;
  final String imagePath;
  final bool isFavorite;
  final int quantity; // New variable
  final double totalItemPrice; // New variable

  const ProductModel({
    required this.name,
    required this.price,
    required this.imagePath,
    this.isFavorite = false,
    this.quantity = 1,          // Default to 1
    this.totalItemPrice = 0.0,  // Default to 0.0
  });

  // Adding copyWith is essential for BLoC state updates
  ProductModel copyWith({
    String? name,
    String? price,
    String? imagePath,
    bool? isFavorite,
    int? quantity,
    double? totalItemPrice,
  }) {
    return ProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      totalItemPrice: totalItemPrice ?? this.totalItemPrice,
    );
  }
}