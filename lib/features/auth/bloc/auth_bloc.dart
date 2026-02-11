import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AuthBloc() : super(AuthInitial()) {

    // SIGN IN
    on<SignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        await userCredential.user?.reload();

        emit(Authenticated(userCredential.user!.uid));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "Login Failed"));
      }
    });

    // SIGN UP (With Profile Update)
    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        // 1. Create the Auth Account
        UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        final String uid = userCredential.user!.uid;

        // 2. Update Auth Profile
        await userCredential.user?.updateDisplayName(event.name);
        await userCredential.user?.reload();

        // 3. SAVE TO FIRESTORE (Clean User Flow)
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'name': event.name,
          'email': event.email,
          'createdAt': FieldValue.serverTimestamp(),
        });

        emit(Authenticated(uid));
      } on FirebaseAuthException catch (e) {
        emit(AuthError(e.message ?? "Registration Failed"));
      }
    });

    // LOGOUT
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await _auth.signOut();
      emit(Unauthenticated());
    });
  }
}