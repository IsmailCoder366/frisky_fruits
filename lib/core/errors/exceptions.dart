class AuthExceptionHandler {
  static String handleException(String code) {
    switch (code) {
      case 'user-not-found': return 'No user found for this email.';
      case 'wrong-password': return 'Incorrect password. Try again.';
      case 'email-already-in-use': return 'Email already registered.';
      case 'invalid-email': return 'The email address is invalid.';
      case 'weak-password': return 'The password is too weak.';
      case 'network-request-failed': return 'Please check your internet connection.';
      default: return 'Authentication failed. Please try again.';
    }
  }
}