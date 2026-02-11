abstract class AuthEvent {}

class SignInRequested extends AuthEvent {
  final String email;
  final String password;
  SignInRequested(this.email, this.password);
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String name; // 👈 Added to capture user's name

  SignUpRequested({
    required this.email,
    required this.password,
    required this.name,
  });
}

class SignOutRequested extends AuthEvent {}