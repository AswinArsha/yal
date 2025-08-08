import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yalgamers/core/secrets/app_secrets.dart';

class TokenService {
  static const _storage = FlutterSecureStorage();

  /// Save tokens and user securely
  static Future<void> saveTokensAndUser({
    required String accessToken,
    required String refreshToken,
    required Map<String, dynamic> user,
  }) async {
    await _storage.write(key: 'accessToken', value: accessToken);
    await _storage.write(key: 'refreshToken', value: refreshToken);
    await _storage.write(key: 'user', value: jsonEncode(user));
  }

  /// Get user data
  static Future<Map<String, dynamic>?> getUser() async {
    final userJson = await _storage.read(key: 'user');
    if (userJson == null) return null;
    return jsonDecode(userJson);
  }

  static Future<String?> getAccessToken() async {
    return await _storage.read(key: 'accessToken');
  }

  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: 'refreshToken');
  }

  /// Refresh token & update storage
  static Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'refreshToken');
    if (refreshToken == null) throw Exception("No refresh token found");

    final response = await http.post(
      Uri.parse(AppUrls.refreshURL), // <- Replace with real endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode != 201) {
      throw Exception("Token refresh failed: ${response.body}");
    }

    final responseBody = jsonDecode(response.body);

    await saveTokensAndUser(
      accessToken: responseBody['accessToken'],
      refreshToken: responseBody['refreshToken'],
      user: responseBody['user'],
    );
    log('token refreshed successfully');
  }

  /// Clear all tokens (logout)
  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }

  /// --- Authorized API Calls ---

  static Future<http.Response> get(String url) async {
    final token = await getAccessToken();
    return http.get(
      Uri.parse(url),
      headers: _authHeaders(token),
    );
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    final token = await getAccessToken();
    return http.post(
      Uri.parse(url),
      headers: _authHeaders(token),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> put(
      String url, Map<String, dynamic> body) async {
    final token = await getAccessToken();
    return http.put(
      Uri.parse(url),
      headers: _authHeaders(token),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String url) async {
    final token = await getAccessToken();
    return http.delete(
      Uri.parse(url),
      headers: _authHeaders(token),
    );
  }

  static Map<String, String> _authHeaders(String? token) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }


}
                              
