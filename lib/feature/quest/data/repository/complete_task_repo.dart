// services/task_service.dart
import 'dart:convert';
import 'dart:developer';

import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';

class SaveTaskService {
  Future<Map<String, dynamic>> saveTask({
    required String taskId,
    required String username,
  }) async {
    final body = {
      "task_id": taskId,
      "file": "",
      "data": {
        "username": username,
      },
    };

    final response = await TokenService.post(AppUrls.saveTaskUrl, body);
    log('response: ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          'Failed to save task: ${response.statusCode} - ${response.body}');
    }
  }
}
