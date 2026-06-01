import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'secure_storage.g.dart';

@Riverpod(keepAlive: true)
SecureStorage secureStorage(Ref ref) {
  return SecureStorage();
}

class SecureStorage {
  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  static const _tokenKey = 'auth_jwt_token';

  Future<void> writeToken(String token) async {
    await _storage.write(key: _tokenKey, value: token);
  }

  Future<String?> readToken() async {
    return await _storage.read(key: _tokenKey);
  }

  Future<void> deleteToken() async {
    await _storage.delete(key: _tokenKey);
  }

  Future<bool> hasToken() async {
    final token = await readToken();
    return token != null && token.isNotEmpty;
  }
}
