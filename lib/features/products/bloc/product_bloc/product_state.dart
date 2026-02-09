class ProductState {
  final int quantity;
  final double basePrice;
  final double totalPrice;
  final int selectedTab; // 0: Description, 1: Review, 2: Discussion

  ProductState({
    required this.quantity,
    required this.basePrice,
    required this.totalPrice,
    this.selectedTab = 0,
  });

  // Factory for the initial state of the bloc
  factory ProductState.initial() => ProductState(
    quantity: 1,
    basePrice: 0.0,
    totalPrice: 0.0,
    selectedTab: 0,
  );

  // Helper method to create a new state with updated values
  ProductState copyWith({
    int? quantity,
    double? basePrice,
    double? totalPrice,
    int? selectedTab,
  }) {
    return ProductState(
      quantity: quantity ?? this.quantity,
      basePrice: basePrice ?? this.basePrice,
      totalPrice: totalPrice ?? this.totalPrice,
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}