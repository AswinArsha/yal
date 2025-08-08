import 'dart:convert';
import 'dart:developer';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/feature/quest/data/model/task_model.dart';

class TaskRepository {
  Future<TaskModel> fetchTaskById(String taskId) async {
    final url = 'https://new.backend.dev.yalgamers.gg/tasks/$taskId';

    final response = await TokenService.get(
      url,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      log('response of tasks: ${response.body}');
      final jsonData = jsonDecode(response.body);
      return TaskModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to fetch task: ${response.statusCode}');
    }
  }
}
