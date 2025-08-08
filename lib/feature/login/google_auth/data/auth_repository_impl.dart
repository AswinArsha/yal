import 'dart:convert';
import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:yalgamers/core/secrets/app_secrets.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/feature/login/google_auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future<void> signInWithGoogle() async {
    try {
      log("log zero");
      final googleSignIn = GoogleSignIn(
        scopes: ['email', 'profile', 'openid'],
        serverClientId: AppUrls.serverClientId,
      );

     // await googleSignIn.signOut(); // For fresh login

    //  final googleUser = await googleSignIn.signIn();

      //if (googleUser == null) throw Exception("User cancelled");

      // final googleAuth = await googleUser.authentication;
      // final idToken = googleAuth.idToken;
      // log("log first");
      // if (idToken == null || idToken.isEmpty) {
      //   throw Exception("Missing ID token");
      // }
      log("log second");
      final response = await http.post(
        Uri.parse(AppUrls.authURL),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'idToken': 'eyJhbGciOiJSUzI1NiIsImtpZCI6ImYxMDMzODYwNzE2ZTNhMmFhYjM4MGYwMGRiZTM5YTcxMTQ4NDZiYTEiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI1MDQxNzAyMjA3ODMtZGxkcHYwOHNpbXE4OTV2MTRqdTh0OWlmc2lxZzA4NWkuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI1MDQxNzAyMjA3ODMtcTh2aHRpYTNjOHNlZmFra2g0cWVtdWxsMG0wNTMycWMuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMTI2NDc2MjU4MDI2Njg4MjE1NjgiLCJlbWFpbCI6ImFyb21hbHNrdW1hcjk3MTQ4QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiQXJvbWFsIFMga3VtYXIiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTHJqM3VyWDJjZDlaWUFEY1lzUkhlNWdBXzFWbWFkZnJ0Vm1hOWExWXF2ano0VWdnPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkFyb21hbCIsImZhbWlseV9uYW1lIjoiUyBrdW1hciIsImlhdCI6MTc1MjU1NTUyNSwiZXhwIjoxNzUyNTU5MTI1fQ.RFf4zkxTFIib9Nu0FvStqHHcM5-x4j2NKTOfC8bWEHepUZH7FZJDVDHVk0tr3s8Cye8E_VjGk2Gy_vmq12KM8fSSRgJXeDaBKl1TMOEf_F4YCjaz8GPub5wyaxGCPQ2eKhZBUYHfRESW1ckK9h3W6Xae4YqekhB0Ixz9NdpkPSpj8Y397RoodR2jZnTGUqvHn5EXFsMjUir7xrRi5WYe1VWGHkZ6YTdnZ_CQxrBNtXFDT6LQOGSAhosunINvTHq3VMvTaRMWdwbNZhlqXCYJ-Lrvbhj1X4aJN5uYl9LW8XoUVx47ALgMI4wMdk6kLTGCcsCY5GcmDqmoIFxUZFgKVw'}),
      );

      log('body is ${response.body}');

      if (response.statusCode != 201) {
        throw Exception("Backend login failed: ${response.body}");
      }

      final responseBody = jsonDecode(response.body);

      await TokenService.saveTokensAndUser(
        accessToken: responseBody['accessToken'],
        refreshToken: responseBody['refreshToken'],
        user: responseBody['user'],
      );
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  @override
  Future<void> logout() async {
    final refreshToken =
        await TokenService.getRefreshToken(); // Add this method if not present

    if (refreshToken == null) {
      log("No refresh token found");
      await TokenService.clearAll();
      return;
    }

    try {
      final response = await TokenService.post(
        AppUrls.logoutURL,
        {'refreshToken': refreshToken}, // match your API key format
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        log('Logout API success');
      } else {
        log('Logout API failed: ${response.body}');
      }
    } catch (e) {
      log('Logout error: $e');
    } finally {
      await TokenService.clearAll(); // Always clear tokens locally
    }
  }
}