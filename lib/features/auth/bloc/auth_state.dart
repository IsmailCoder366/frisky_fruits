abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

// User is successfully logged in
class Authenticated extends AuthState {
  final String uid;
  Authenticated(this.uid);
}

// User is logged out
class Unauthenticated extends AuthState {}

// Something went wrong (Wrong password, no internet, etc.)
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}