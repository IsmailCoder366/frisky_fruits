import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import '../repository/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<ProcessStripePayment>((event, emit) async {
      emit(PaymentLoading());

      try {
        // 1. Call your repository to handle the Stripe logic
        // For now, we simulate a network delay
        await Future.delayed(const Duration(seconds: 2));

        // Logic: repository.makePayment(event.amount);

        emit(PaymentSuccess());
      } catch (e) {
        emit(PaymentFailure(e.toString()));
      }
    });
  }
}