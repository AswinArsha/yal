import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/recommended_games_widget.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? name;
  String? userName;
  
  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  
   Future<void> _loadUser() async {
    final user = await TokenService.getUser();
    setState(() {
      name = user?['name'] ?? 'Guest';
      userName=user?['username']??'guest_user';
    });
  }

  bool showProfile = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.buttonBackground,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: const AssetImage(
                  'assets/images/bg/dall_e.png'), // Replace with actual image
              radius: 18.h,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$name's Profile",
                  style: AppTextStyles.medium(
                    fontWeight: FontWeight.w500,
                    size: 14.sp,
                    color: AppColors.baseWhite,
                  ),
                ),
                Text(userName??'guest_user',
                    style: AppTextStyles.medium(
                      fontWeight: FontWeight.w400,
                      size: 10.sp,
                      color: AppColors.baseWhite.withOpacity(0.4),
                    ))
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            height: 35.h,
            width: double.infinity,
            color: const Color(0xFF8EC9ED),
            child: TextButton.icon(
              iconAlignment: IconAlignment.end,
              onPressed: () => setState(() => showProfile = !showProfile),
              icon: const Icon(Icons.keyboard_arrow_down_outlined,
                  color: Colors.black),
              label: Text(
                "Choose Recommended Games",
                style: AppTextStyles.small(
                    size: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF212F38)),
              ),
            ),
          ),
        ),
      ),
      body: showProfile
          ? _buildChatView()
          : RecommendedGamesView(
              gameCardBuilder: () => _buildGameCard(),
            ),
    );
  }

  Widget _buildGameCard() {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.baseWhite.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset('assets/images/bg/free_fire_blue.png',
              width: 90.w,
              height: 90.h,
              fit: BoxFit.cover), // Replace with actual asset
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text("Free Fire",
                        style: AppTextStyles.mediumBold(
                            size: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.baseWhite.withOpacity(0.9))),
                    const Spacer(),
                    const Icon(Icons.star, color: Colors.yellow, size: 18),
                    const SizedBox(width: 6),
                    Text("4.8",
                        style: AppTextStyles.small(
                            fontWeight: FontWeight.w500,
                            size: 12,
                            color: AppColors.xpColor)),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Welcome to the heart-poun...",
                    style: AppTextStyles.small(
                        size: 12,
                        fontWeight: FontWeight.w400,
                        color: AppColors.baseWhite.withOpacity(0.5))),
                const SizedBox(height: 12),
                Row(
                  children: [
                    LuminousCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        prefixIcon: Icons.circle,
                        iconSize: 4.h,
                        fontWeight: FontWeight.w500,
                        luminousColor: const Color(0xFF8EC9ED),
                        label: 'Fighting'),
                    const SizedBox(width: 6),
                    LuminousCard(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        prefixIcon: Icons.circle,
                        iconSize: 4.h,
                        fontWeight: FontWeight.w500,
                        label: "Open World",
                        luminousColor: const Color(0xFF8EC9ED)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              const Center(
                  child: Text("21 Jul, 2024",
                      style: TextStyle(color: Colors.grey, fontSize: 12))),
              const SizedBox(height: 10),
              _chatBubble("Hey everyone! How's it going?", false, "02:35 pm"),
              _chatBubble(
                  "Hi Ali ! I'm good, just finished my workout. How about you?",
                  true,
                  "02:37 pm"),
              _chatBubble(
                  "Hi Ali ! I'm good, just finished my workout. How about you?",
                  true,
                  "02:37 pm"),
              const SizedBox(height: 10),
              _chatBubble("Hey everyone! How's it going?", false, "12:32 pm"),
            ],
          ),
        ),
        _buildInputBar(),
      ],
    );
  }

  Widget _chatBubble(String message, bool isSender, String time) {
    return Align(
      alignment: isSender ? Alignment.centerLeft : Alignment.centerRight,
      child: Column(
        crossAxisAlignment:
            isSender ? CrossAxisAlignment.start : CrossAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 0.06),
              borderRadius: BorderRadius.circular(12),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.6,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isSender)
                     Text(name ?? 'Guest User',
                        style: TextStyle(fontSize: 12, color: Colors.yellow)),
                  if (isSender)
                    const Divider(
                      thickness: 0.5,
                      color: Color.fromRGBO(255, 255, 255, 0.03),
                    ),
                  Text(message,
                      style: AppTextStyles.medium(
                          size: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.80))),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: isSender
                        ? MainAxisAlignment.start
                        : MainAxisAlignment.end,
                    children: [
                      Text(
                        "Today at $time",
                        style: AppTextStyles.medium(
                          size: 10.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color.fromRGBO(255, 255, 255, 0.30),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputBar() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Image.asset(height: 40.h, 'assets/icons/gallery.png'),
          const SizedBox(width: 10),
          Image.asset(height: 40.h, 'assets/icons/smile.png'),
          const SizedBox(width: 10),
          Expanded(
            child: TextField(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen();
                  },
                ));
              },
              decoration: InputDecoration(
                hintText: "Type here...",
                filled: true,
                hintStyle: AppTextStyles.small(
                    color: AppColors.baseWhite.withOpacity(0.6),
                    size: 14.sp,
                    fontWeight: FontWeight.w400),
                fillColor: AppColors.baseWhite.withOpacity(0.05),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(3.36),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
