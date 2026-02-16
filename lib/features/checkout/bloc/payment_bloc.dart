import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_event.dart';
import 'payment_state.dart';
import '../repository/payment_repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentRepository repository;

  PaymentBloc(this.repository) : super(PaymentInitial()) {
    on<ProcessStripePayment>((event, emit) async {
      print("DEBUG: PaymentBloc -> Event Received for amount: ${event.amount}");
      emit(PaymentLoading());

      try {
        // 1. Actually call the repository (No more simulation!)
        // We pass the amount and a default currency
        final result = await repository.createPaymentIntent(event.amount, "usd");

        print("DEBUG: PaymentBloc -> Stripe Response: ${result['id']}");

        // 2. Check if we got a client_secret back from Stripe
        if (result.containsKey('client_secret')) {
          // Note: In a production app, you would use the Stripe SDK here
          // to confirm the payment on the mobile device.
          emit(PaymentSuccess());
          print("DEBUG: PaymentBloc -> Status: Success");
        } else {
          throw Exception("No client secret received from Stripe");
        }

      } catch (e) {
        print("DEBUG: PaymentBloc -> Error occurred: $e");
        emit(PaymentFailure(e.toString()));
      }
    });
  }
}