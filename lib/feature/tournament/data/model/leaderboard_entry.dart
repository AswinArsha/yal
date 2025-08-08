class LeaderboardEntry {
  final String rank;
  final String playerName;
  final String teamName; // Only used for team leaderboard
  final String avatarUrl;
  final int kills;
  final int points;

  LeaderboardEntry({
    required this.rank,
    required this.playerName,
    this.teamName = '',
    required this.avatarUrl,
    required this.kills,
    required this.points,
  });
}