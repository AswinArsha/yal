import 'dart:ffi' if (dart.library.html) 'dart:js';

import 'package:flutter/material.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/input_bar_widget.dart';
import 'package:yalgamers/feature/networking/presentation/pages/group_details_screen.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return GroupDetailsScreen();
                  },
                ));
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/profile-networking.jpg'),
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shockwaves Ai',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  '21 Members',
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Center(
            child: Text(
              '21Jul, 2024',
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMessage(
                  isMe: true,
                  message: "Hey everyone! How's it going?",
                  time: "Today at 02:35 pm",
                  avatar: 'https://i.pravatar.cc/300',
                ),
                _buildUserReply(
                  name: 'Mousa',
                  message:
                      "Hi Ali ! I'm good, just finished my workout. How about you?",
                  time: "Today at 02:37 pm",
                ),
                _buildUserReply(
                  name: 'Ali Haninah',
                  message:
                      "Hi Ali ! I'm good, just finished my workout. How about you?",
                  time: "Today at 02:37 pm",
                ),
                _buildMessage(
                  isMe: true,
                  message: "Hey everyone! How's it going?",
                  time: "Today at 02:35 pm",
                  avatar: 'https://i.pravatar.cc/300',
                ),
                Center(
                  child: Text(
                    'Today at 12:32',
                    style: TextStyle(color: Colors.grey[500], fontSize: 12),
                  ),
                ),
                _buildUserReply(
                  name: 'Ali Haninah',
                  message:
                      "Hi Ali ! I'm good, just finished my workout. How about you?",
                  time: "Today at 02:37 pm",
                ),
                _buildMessage(
                  isMe: true,
                  message: "Hey everyone! How's it going?",
                  time: "Today at 02:35 pm",
                  avatar: 'https://i.pravatar.cc/300',
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white24, height: 1),
          InputBar(
            onTap: () {},
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          //   child: Row(
          //     children: [
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.camera_alt, color: Colors.white70),
          //       ),
          //       IconButton(
          //         onPressed: () {},
          //         icon: const Icon(Icons.emoji_emotions_outlined,
          //             color: Colors.white70),
          //       ),
          //       Expanded(
          //         child: TextField(
          //           style: const TextStyle(color: Colors.white),
          //           decoration: InputDecoration(
          //             hintText: 'Type here...',
          //             hintStyle: const TextStyle(color: Colors.white38),
          //             border: InputBorder.none,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildMessage({
    required bool isMe,
    required String message,
    required String time,
    required String avatar,
  }) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 4),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1C121F),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
          Text(
            time,
            style: TextStyle(color: Colors.grey[500], fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _buildUserReply({
    required String name,
    required String message,
    required String time,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundColor: Colors.white,
          backgroundImage: AssetImage('assets/chat-profilepic.png'),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 4),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1C121F),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(color: Colors.grey[500], fontSize: 10),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
