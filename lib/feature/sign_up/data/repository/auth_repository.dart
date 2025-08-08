import 'dart:developer';

import 'package:pocketbase/pocketbase.dart';

class AuthRepository {
  final PocketBase pb = PocketBase('https://devdash.yalgamers.gg');
  Future<bool> signInWithEmail(String email, String password) async {
    try {
      final body = {
        "email": email,
        "password": password,
        "passwordConfirm": password,
      };
      await pb.collection('users').create(body: body);
      return true;
    } catch (e) {
      if (e is ClientException) {
        final response = e.response;

        // Extract top-level message if available
        String errorMessage = response['message'] ?? "Sign up failed";

        // Check for field-level errors (e.g., 'password')
        final errorData = response['data'];
        if (errorData is Map && errorData.isNotEmpty) {
          final firstField = errorData.keys.first;
          final fieldError = errorData[firstField];

          if (fieldError is Map && fieldError['message'] != null) {
            log('${fieldError['message']}');
            errorMessage = fieldError['message'];
          }
        }

        throw Exception(errorMessage);
      }

      throw Exception("Sign up failed. Please try again.");
    }
  }
}
