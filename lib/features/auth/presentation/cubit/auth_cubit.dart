import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/auth_repository.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthAuthenticated extends AuthState {
  AuthAuthenticated(this.user);
  final User user;
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  AuthError(this.message);
  final String message;
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({AuthRepository? repository})
    : _repository = repository,
      super(AuthInitial()) {
    if (repository != null) {
      _listenToAuthChanges();
    }
  }

  final AuthRepository? _repository;

  void _listenToAuthChanges() {
    _repository?.authStateChanges().listen((user) {
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());
    try {
      await _repository?.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Authentication failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    emit(AuthLoading());
    try {
      await _repository?.createUserWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Registration failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    emit(AuthLoading());
    try {
      await _repository?.signInWithGoogle();
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Google sign in failed'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _repository?.signOut();
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _repository?.sendPasswordResetEmail(email);
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message ?? 'Failed to send reset email'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
