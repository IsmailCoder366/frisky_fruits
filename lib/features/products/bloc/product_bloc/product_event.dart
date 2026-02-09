abstract class ProductEvent {
  const ProductEvent();
}

/// Initializes the product details when the screen opens
class InitializeProduct extends ProductEvent {
  final double basePrice;
  final int initialTabIndex;

  const InitializeProduct({
    required this.basePrice,
    this.initialTabIndex = 0, // Defaults to Description tab
  });
}

/// Increases the product count by 1
class IncrementQuantity extends ProductEvent {}

/// Decreases the product count by 1 (minimum is 1)
class DecrementQuantity extends ProductEvent {}

/// Switches between Description, Review, and Discussion
class ChangeTab extends ProductEvent {
  final int tabIndex;

  const ChangeTab(this.tabIndex);
}