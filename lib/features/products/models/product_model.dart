class ProductModel {
  final String name;
  final String price; // UI Display price (e.g., "$5.0")
  final double priceValue; // 👈 Added: Actual number for calculations
  final String imagePath;
  final bool isFavorite;
  final int quantity;
  final double totalItemPrice;

  const ProductModel({
    required this.name,
    required this.price,
    this.priceValue = 0.0, // Default to 0.0
    required this.imagePath,
    this.isFavorite = false,
    this.quantity = 1,
    this.totalItemPrice = 0.0,
  });

  // 🛠 Optimized copyWith
  ProductModel copyWith({
    String? name,
    String? price,
    double? priceValue,
    String? imagePath,
    bool? isFavorite,
    int? quantity,
    double? totalItemPrice,
  }) {
    return ProductModel(
      name: name ?? this.name,
      price: price ?? this.price,
      priceValue: priceValue ?? this.priceValue,
      imagePath: imagePath ?? this.imagePath,
      isFavorite: isFavorite ?? this.isFavorite,
      quantity: quantity ?? this.quantity,
      totalItemPrice: totalItemPrice ?? this.totalItemPrice,
    );
  }

  // --- Useful for the Creator module later ---
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'priceValue': priceValue,
      'imagePath': imagePath,
      'quantity': quantity,
      'totalItemPrice': totalItemPrice,
    };
  }
}