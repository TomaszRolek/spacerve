import 'package:supabase_flutter/supabase_flutter.dart';

class AuthClient {
  final client = Supabase.instance.client;

  Future<AuthResponse> signIn(String email, String password) async {
    return await client.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signUp(String email, String password) {
    return client.auth.signUp(email: email, password: password);
  }

  Future<bool> get isLogged async {
    await Future.delayed(Duration.zero);
    final session = client.auth.currentSession;
    return session != null;
  }

  String get currentLoggedUserId {
    final currentUser = client.auth.currentUser;
    if (currentUser != null) {
      return currentUser.id.toString();
    } else {
      return '';
    }
  }

  String get currentLoggedUserEmail {
    final currentUser = client.auth.currentUser;
    if (currentUser != null) {
      return currentUser.email.toString();
    } else {
      return '';
    }
  }

  Future<void> signOut() async {
    return await client.auth.signOut();
  }
}
