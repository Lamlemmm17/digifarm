import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginProvider = AsyncNotifierProvider<LoginNotifier, void>(() {
  return LoginNotifier();
});

class LoginNotifier extends AsyncNotifier<void> {
  @override
  FutureOr<void> build() async {
    return;
  }

  Future<void> signIn(String email, String password) async {
    final auth = ref.read(authProvider);

    try {
      state = const AsyncValue.loading();

      await auth.signInWithEmailAndPassword(email: email, password: password);

      state = const AsyncValue.data(null);

    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
  
  Future<void> signOut() async {
    await ref.read(authProvider).signOut();
  }
}

final authProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.watch(authProvider).authStateChanges();
});

final currentUserIdProvider = Provider<String?>((ref) {
  final userAsyncValue = ref.watch(authStateProvider);

  return userAsyncValue.value?.uid;
});
