import 'package:flutter/material.dart';

Widget buildLeaderboardTab(List<Map<String, dynamic>> leaderboard) {
  return ListView.builder(
    padding: const EdgeInsets.only(bottom: 10),
    itemCount: leaderboard.length,
    itemBuilder: (context, index) {
      final item = leaderboard[index];
      final isMe = item['name'].toString().contains('(Me)');
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
              color: isMe ? Colors.blueGrey.withOpacity(0.1) : Colors.black),
          color: isMe ? Colors.blueGrey.withOpacity(0.2) : Colors.grey.shade900,
          borderRadius: BorderRadius.circular(6),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          leading: CircleAvatar(
            radius: 12,
            backgroundColor: Colors.orange,
            child: Text(item['rank'].toString()),
          ),
          title: Text(
            item['name'].toString(),
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.circle, color: Colors.amber, size: 14),
              const SizedBox(width: 4),
              Text('${item['coins']}',
                  style: const TextStyle(color: Colors.amber)),
              const SizedBox(width: 16),
              const Text('XP',
                  style: TextStyle(color: Colors.amber, fontSize: 16)),
              const SizedBox(width: 4),
              Text('${item['xp']}',
                  style: const TextStyle(color: Colors.amber)),
            ],
          ),
        ),
      );
    },
  );
}

final leaderboard = [
  {'rank': '122', 'name': 'Sabbir Islam (Me)', 'coins': 100, 'xp': 100},
  {'rank': '01', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
  {'rank': '02', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
  {'rank': '03', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
  {'rank': '04', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
  {'rank': '04', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
  {'rank': '04', 'name': 'Ali Haninah', 'coins': 100, 'xp': 100},
];
