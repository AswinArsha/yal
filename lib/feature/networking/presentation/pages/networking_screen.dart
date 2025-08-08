import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart'; // Assuming you already have this
import 'package:yalgamers/feature/networking/presentation/pages/chat_screen.dart'; // Your text style helper

class NetworkingScreen extends StatelessWidget {
  const NetworkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF322A35),
              ),
              padding: const EdgeInsets.all(8),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        title: Text(
          'Networking',
          style: AppTextStyles.small(
            size: 12,
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // No extra top padding; clean flush section
          Container(
            color: const Color(0xFF150B18),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Projects Chat Rooms',
                      style: AppTextStyles.small(
                        size: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '21 Rooms',
                      style: AppTextStyles.small(
                        size: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white24, width: 1.5),
                  ),
                  child: IconButton(
                    icon:
                        const Icon(Icons.search, size: 20, color: Colors.white),
                    onPressed: () {
                      print("Search button pressed");
                    },
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Color(0xFF211724),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ChatScreen(),
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                AssetImage('assets/profile-networking.jpg'),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'SUI',
                                      style: AppTextStyles.small(
                                        size: 16,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF132417),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '● 12 Online',
                                        style: AppTextStyles.small(
                                          size: 10,
                                          color: const Color(0xFF1FD031),
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Last updated 02s ago',
                                  style: AppTextStyles.small(
                                    size: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF71756),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '99+',
                              style: AppTextStyles.small(
                                size: 10,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Color.fromARGB(30, 255, 255, 255),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
