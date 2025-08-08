import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const _accessTokenKey = 'accessToken';
  static const _refreshTokenKey = 'refreshToken';

  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  // Save tokens
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
    await _secureStorage.write(key: _refreshTokenKey, value: refreshToken);
  }

  // Read access token
  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  // Read refresh token
  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: _refreshTokenKey);
  }

  // Delete tokens
  Future<void> clearTokens() async {
    await _secureStorage.delete(key: _accessTokenKey);
    await _secureStorage.delete(key: _refreshTokenKey);
  }
}
