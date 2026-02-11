import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/errors/exceptions.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {

    // SIGN UP LOGIC
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // Save to Firestore & Update Profile
        await userCredential.user?.updateDisplayName(event.name);
        await _firestore.collection('users').doc(userCredential.user!.uid).set({
          'name': event.name,
          'email': event.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
        await userCredential.user?.reload();

        emit(Authenticated(userCredential.user!.uid));
      } on FirebaseAuthException catch (e) {
        // 👈 Handle specific Firebase errors
        emit(AuthError(AuthExceptionHandler.handleException(e.code)));
      } catch (e) {
        // Handle network or coding errors
        emit(AuthError("Something went wrong. Please check your connection."));
      }
    });

    // SIGN IN LOGIC
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        await _auth.currentUser?.reload();
        emit(Authenticated(_auth.currentUser!.uid));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(AuthExceptionHandler.handleException(e.code)));
      } catch (e) {
        emit(AuthError("Failed to sign in. Please try again."));
      }
    });

    // LOGOUT LOGIC
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _auth.signOut();
      emit(Unauthenticated());
    });
  }
}