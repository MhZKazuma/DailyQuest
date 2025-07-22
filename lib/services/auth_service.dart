import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final supabase = Supabase.instance.client;

  Future<void> login({required String email, required String password}) async {
    final response = await supabase.auth.signInWithPassword(
      email: email,
      password: password,
    );

    if (response.user == null) {
      throw Exception('Login gagal. Periksa email dan password.');
    }
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    final response = await supabase.auth.signUp(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw Exception('Registrasi gagal');
    }

    // Tambahkan data ke tabel `profiles`
    await supabase.from('profiles').insert({
      'id': user.id,
      'username': email.split('@')[0], // default username
      'avatar_url': null,
    });
  }

  Future<void> logout() async {
    await supabase.auth.signOut();
  }
}
//auth service