class AuthExceptionHandler {
  static String handleException(String errorCode) {
    switch (errorCode) {
    // THE GENERIC ERROR FIX
      case 'invalid-credential':
        return "Invalid email or password. Please check your details and try again.";

      case 'channel-error':
        return "Please fill in all fields.";

    // Email Errors
      case 'invalid-email':
        return "The email address is not formatted correctly.";
      case 'email-already-in-use':
        return "This email is already registered. Try signing in.";

    // Password Errors
      case 'weak-password':
        return "Password is too weak. Please use at least 6 characters.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";

    // Network & System
      case 'network-request-failed':
        return "No internet connection detected. Please check your network.";
      case 'too-many-requests':
        return "Too many failed attempts. Please wait a moment.";

      default:
      // Use this to see the raw code in your console while debugging
        print("Firebase Error Code: $errorCode");
        return "Authentication failed. Please try again.";
    }
  }
}