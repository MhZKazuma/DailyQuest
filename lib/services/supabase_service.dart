import 'dart:io';
import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Ambil data profil dari tabel `profiles`
  Future<Map<String, dynamic>?> getProfile() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final response =
        await _client.from('profiles').select().eq('id', user.id).single();

    return response;
  }

  /// Update profil pengguna
  Future<void> updateProfile({
    required String username,
    String? avatarUrl,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) throw 'User belum login';

    final updateData = {
      'username': username,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
    };

    await _client.from('profiles').update(updateData).eq('id', user.id);
  }

  /// Upload gambar dari File (untuk mobile & desktop)
  Future<String> uploadImage(File file, String bucket, String path) async {
    final mimeType = lookupMimeType(file.path);
    final bytes = await file.readAsBytes();

    final response = await _client.storage
        .from(bucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: mimeType ?? 'image/jpeg'),
        );

    if (response.isEmpty) {
      throw 'Gagal upload gambar';
    }

    return _client.storage.from(bucket).getPublicUrl(path);
  }

  /// Upload gambar dari ByteData (untuk Web)
  Future<String> uploadImageBytes(
    Uint8List bytes,
    String bucket,
    String path,
  ) async {
    final response = await _client.storage
        .from(bucket)
        .uploadBinary(
          path,
          bytes,
          fileOptions: const FileOptions(contentType: 'image/jpeg'),
        );

    if (response.isEmpty) {
      throw 'Gagal upload gambar (web)';
    }

    return _client.storage.from(bucket).getPublicUrl(path);
  }
}
