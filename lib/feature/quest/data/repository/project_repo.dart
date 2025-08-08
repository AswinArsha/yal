import 'dart:convert';
import 'dart:developer';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/feature/quest/data/model/project_model.dart';

class ProjectService {
  static Future<List<Project>> fetchProjects() async {
    const url =
        "https://new.backend.dev.yalgamers.gg/projects?include_tasks=true";
    final response = await TokenService.get(
      url,
    );
    //log('response: ${response.body}');
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body)['data'];
      return data.map((json) => Project.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load projects: ${response.body}");
    }
  }
}
