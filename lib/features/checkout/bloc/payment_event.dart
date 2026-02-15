abstract class PaymentEvent {}

class ProcessStripePayment extends PaymentEvent {
  final double amount;
  ProcessStripePayment(this.amount);
}

// You can add more events here later, like ResetPayment