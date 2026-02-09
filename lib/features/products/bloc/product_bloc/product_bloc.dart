import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState.initial()) {

    // Handles named parameters from the updated event
    on<InitializeProduct>((event, emit) {
      emit(state.copyWith(
        basePrice: event.basePrice,
        totalPrice: event.basePrice,
        quantity: 1,
        selectedTab: event.initialTabIndex, // Correctly sets the starting tab
      ));
    });

    on<IncrementQuantity>((event, emit) {
      final newQuantity = state.quantity + 1;
      emit(state.copyWith(
        quantity: newQuantity,
        totalPrice: state.basePrice * newQuantity,
      ));
    });

    on<DecrementQuantity>((event, emit) {
      if (state.quantity > 1) {
        final newQuantity = state.quantity - 1;
        emit(state.copyWith(
          quantity: newQuantity,
          totalPrice: state.basePrice * newQuantity,
        ));
      }
    });

    // Updates the tab index for the AnimatedContainer underline
    on<ChangeTab>((event, emit) {
      emit(state.copyWith(selectedTab: event.tabIndex));
    });
  }
}