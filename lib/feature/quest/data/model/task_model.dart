class TaskModel {
  final String id;
  final String type;
  final String titleEn;
  final String titleAr;
  final String descriptionEn;
  final String descriptionAr;
  final int xp;
  final String projectId;
  final String? link;
  final DateTime? created;
  final DateTime? updated;
  final String? taskDate;

  TaskModel({
    required this.id,
    required this.type,
    required this.titleEn,
    required this.titleAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.xp,
    required this.projectId,
    this.link,
    this.created,
    this.updated,
    this.taskDate,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      descriptionEn: json['description_en'] ?? '',
      descriptionAr: json['description_ar'] ?? '',
      xp: json['xp'] ?? 0,
      projectId: json['project_id'] ?? '',
      link: json['data']?['link'],
      created: json['created'] != null ? DateTime.tryParse(json['created']) : null,
      updated: json['updated'] != null ? DateTime.tryParse(json['updated']) : null,
      taskDate: json['taskDate'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'xp': xp,
      'project_id': projectId,
      'data': {'link': link},
      'created': created?.toIso8601String(),
      'updated': updated?.toIso8601String(),
      'taskDate': taskDate,
    };
  }
}
