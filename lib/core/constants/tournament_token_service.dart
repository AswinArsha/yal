import 'dart:convert';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:yalgamers/core/secrets/app_secrets.dart';

class TournamentTokenService {
  static const _storage = FlutterSecureStorage();


  /// Refresh token & update storage
  static Future<void> refreshToken() async {
    final refreshToken = await _storage.read(key: 'tournamentRefreshToken');
    if (refreshToken == null) throw Exception("No refresh token found");

    final response = await http.post(
      Uri.parse(AppUrls.tournamentRefreshURL), // <- Replace with real endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'refreshToken': refreshToken}),
    );

    if (response.statusCode != 201) {
      throw Exception("Token refresh failed: ${response.body}");
    }

    final responseBody = jsonDecode(response.body);

    await saveTournamentTokensAndUser(
      accessToken: responseBody['tournamentAccessToken'],
      refreshToken: responseBody['tournamentRefreshToken'],
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
    final token = await getTournamentAccessToken();
    return http.get(
      Uri.parse(url),
      headers: _authHeaders(token),
    );
  }

  static Future<http.Response> post(
      String url, Map<String, dynamic> body) async {
    final token = await getTournamentAccessToken();
    return http.post(
      Uri.parse(url),
      headers: _authHeaders(token),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> put(
      String url, Map<String, dynamic> body) async {
    final token = await getTournamentAccessToken();
    return http.put(
      Uri.parse(url),
      headers: _authHeaders(token),
      body: jsonEncode(body),
    );
  }

  static Future<http.Response> delete(String url) async {
    final token = await getTournamentAccessToken();
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

  static const _tournamentAccessTokenKey = 'tournamentAccessToken';
static const _tournamentRefreshTokenKey = 'tournamentRefreshToken';
static const _tournamentUserKey = 'tournamentUser';

static Future<void> saveTournamentTokensAndUser({
  required String accessToken,
  required String refreshToken,
  required Map<String, dynamic> user,
}) async {
  await _storage.write(key: _tournamentAccessTokenKey, value: accessToken);
  await _storage.write(key: _tournamentRefreshTokenKey, value: refreshToken);
  await _storage.write(key: _tournamentUserKey, value: jsonEncode(user));
}

static Future<String?> getTournamentAccessToken() async {
  return await _storage.read(key: _tournamentAccessTokenKey);
}

static Future<String?> getTournamentRefreshToken() async {
  return await _storage.read(key: _tournamentRefreshTokenKey);
}

static Future<Map<String, dynamic>?> getTournamentUser() async {
  final json = await _storage.read(key: _tournamentUserKey);
  if (json == null) return null;
  return jsonDecode(json);
}

}
