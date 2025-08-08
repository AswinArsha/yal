class TournamentAuthModel {
  final String accessToken;
  final String refreshToken;
  final TournamentUser user;

  TournamentAuthModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory TournamentAuthModel.fromJson(Map<String, dynamic> json) {
    return TournamentAuthModel(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
      user: TournamentUser.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
        'user': user.toJson(),
      };
}

class TournamentUser {
  final String id;
  final String? email;
  final String name;
  final String? username;
  final dynamic metamask;
  final uid;

  TournamentUser({
    required this.id,
    required this.email,
    required this.name,
    required this.username,
    required this.metamask,
    required this.uid,
  });

  factory TournamentUser.fromJson(Map<String, dynamic> json) {
    return TournamentUser(
      id: json['id'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      metamask: json['metamask'],
      uid: json['uid'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'username': username,
        'metamask': metamask,
        'uid': uid,
      };
}
