import 'dart:convert';

class Project {
  final String id;
  final DateTime created;
  final DateTime updated;
  final bool notificationSent;
  final String slug;
  final String titleEn;
  final String titleAr;
  final String subTextEn;
  final String subTextAr;
  final bool publish;
  final bool isFeatured;
  final String image;
  final String start;
  final String deadline;
  final String pid;
  final String chatRoomAboutEn;
  final String chatRoomAboutAr;
  final List<ChatLink> chatLinks;
  final String blockchainNetworkId;
  final String? kolsUserId;
  final String bannerImg;
  final String featuredImg;
  final String? nftLink;
  final String? nftImg;
  final bool skipDeadlineChecking;
  final bool isEnded;
  final bool isActive;
  final List<ProjectsTasks> tasks;
  final List<Reward> rewards;

  Project({
    required this.id,
    required this.created,
    required this.updated,
    required this.notificationSent,
    required this.slug,
    required this.titleEn,
    required this.titleAr,
    required this.subTextEn,
    required this.subTextAr,
    required this.publish,
    required this.isFeatured,
    required this.image,
    required this.start,
    required this.deadline,
    required this.pid,
    required this.chatRoomAboutEn,
    required this.chatRoomAboutAr,
    required this.chatLinks,
    required this.blockchainNetworkId,
    this.kolsUserId,
    required this.bannerImg,
    required this.featuredImg,
    this.nftLink,
    this.nftImg,
    required this.skipDeadlineChecking,
    required this.isEnded,
    required this.isActive,
    required this.tasks,
    required this.rewards,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'] ?? '',
      created: DateTime.parse(json['created']),
      updated: DateTime.parse(json['updated']),
      notificationSent: json['notfication_sent'] ?? false,
      slug: json['slug'] ?? '',
      titleEn: json['title_en'] ?? '',
      titleAr: json['title_ar'] ?? '',
      subTextEn: json['subText_en'] ?? '',
      subTextAr: json['subText_ar'] ?? '',
      publish: json['publish'] ?? false,
      isFeatured: json['isFeatured'] ?? false,
      image: json['image'] ?? '',
      start: json['start'] ?? '',
      deadline: json['deadline'] ?? '',
      pid: json['pid'] ?? '',
      chatRoomAboutEn: json['chat_room_about_en'] ?? '',
      chatRoomAboutAr: json['chat_room_about_ar'] ?? '',
      chatLinks: (json['chat_links'] as List<dynamic>?)
              ?.map((e) => ChatLink.fromJson(e))
              .toList() ??
          [],
      blockchainNetworkId: json['blockchain_network_id'] ?? '',
      kolsUserId: json['kols_user_id'],
      bannerImg: json['banner_img'] ?? '',
      featuredImg: json['featured_img'] ?? '',
      nftLink: json['nft_link'],
      nftImg: json['nft_img'],
      skipDeadlineChecking: json['skip_deadline_checking'] ?? false,
      isEnded: json['isEnded'] ?? false,
      isActive: json['isActive'] ?? false,
      tasks: (json['tasks'] as List<dynamic>?)
              ?.map((e) => ProjectsTasks.fromJson(e))
              .toList() ??
          [],
      rewards: (json['rewards'] as List<dynamic>?)
              ?.map((e) => Reward.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created': created.toIso8601String(),
      'updated': updated.toIso8601String(),
      'notfication_sent': notificationSent,
      'slug': slug,
      'title_en': titleEn,
      'title_ar': titleAr,
      'subText_en': subTextEn,
      'subText_ar': subTextAr,
      'publish': publish,
      'isFeatured': isFeatured,
      'image': image,
      'start': start,
      'deadline': deadline,
      'pid': pid,
      'chat_room_about_en': chatRoomAboutEn,
      'chat_room_about_ar': chatRoomAboutAr,
      'chat_links': chatLinks.map((e) => e.toJson()).toList(),
      'blockchain_network_id': blockchainNetworkId,
      'kols_user_id': kolsUserId,
      'banner_img': bannerImg,
      'featured_img': featuredImg,
      'nft_link': nftLink,
      'nft_img': nftImg,
      'skip_deadline_checking': skipDeadlineChecking,
      'isEnded': isEnded,
      'isActive': isActive,
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'rewards': rewards.map((e) => e.toJson()).toList(),
    };
  }

  DateTime get deadlineDate => DateTime.parse(deadline);
  DateTime get startDate => DateTime.parse(start);
}

class ChatLink {
  final String key;
  final String value;

  ChatLink({
    required this.key,
    required this.value,
  });

  factory ChatLink.fromJson(Map<String, dynamic> json) {
    return ChatLink(
      key: json['key'] ?? '',
      value: json['value'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
    };
  }
}

class ProjectsTasks {
  final String taskId;
  final String taskType;
  final String taskTitleEn;
  final String taskTitleAr;
  final String taskDescriptionEn;
  final String taskDescriptionAr;
  final int taskXp;
  final Map<String, dynamic> taskData;
  final String taskProjectId;
  final String? taskTaskDate;
  final bool? taskLogsVerified;
  final String? taskLogId;
  final String state;

  ProjectsTasks({
    required this.taskId,
    required this.taskType,
    required this.taskTitleEn,
    required this.taskTitleAr,
    required this.taskDescriptionEn,
    required this.taskDescriptionAr,
    required this.taskXp,
    required this.taskData,
    required this.taskProjectId,
    this.taskTaskDate,
    this.taskLogsVerified,
    this.taskLogId,
    required this.state,
  });

  factory ProjectsTasks.fromJson(Map<String, dynamic> json) {
    return ProjectsTasks(
      taskId: json['task_id'] ?? '',
      taskType: json['task_type'] ?? '',
      taskTitleEn: json['task_title_en'] ?? '',
      taskTitleAr: json['task_title_ar'] ?? '',
      taskDescriptionEn: json['task_description_en'] ?? '',
      taskDescriptionAr: json['task_description_ar'] ?? '',
      taskXp: json['task_xp'] ?? 0,
      taskData: Map<String, dynamic>.from(json['task_data'] ?? {}),
      taskProjectId: json['task_project_id'] ?? '',
      taskTaskDate: json['task_taskDate'],
      taskLogsVerified: json['task_logs_verified'],
      taskLogId: json['task_log_id'],
      state: json['state'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'task_id': taskId,
      'task_type': taskType,
      'task_title_en': taskTitleEn,
      'task_title_ar': taskTitleAr,
      'task_description_en': taskDescriptionEn,
      'task_description_ar': taskDescriptionAr,
      'task_xp': taskXp,
      'task_data': taskData,
      'task_project_id': taskProjectId,
      'task_taskDate': taskTaskDate,
      'task_logs_verified': taskLogsVerified,
      'task_log_id': taskLogId,
      'state': state,
    };
  }
}

class Reward {
  final String key;
  final String value;
  final int amount;

  Reward({
    required this.key,
    required this.value,
    required this.amount,
  });

  factory Reward.fromJson(Map<String, dynamic> json) {
    return Reward(
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      amount: json['Amount'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'Amount': amount,
    };
  }
}
