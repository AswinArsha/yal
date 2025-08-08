import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/input_bar_widget.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/send_screen.dart';

class SupportChatScreen extends StatelessWidget {
  const SupportChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.buttonBackground,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CustomArrowBack(),
        ),
        title: Text(
          'Support Chat',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          decoration: BoxDecoration(color: Color(0xFF100613)),
          child: Column(
            children: [
              // 🟪 Complaint Card
              Container(
                decoration: BoxDecoration(color: Color(0xFF170D1A)),
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C121F),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.asset(
                            'assets/images/bg/ticket.png',
                            height: 40,
                            width: 40,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Have Fun Mini Games\nDoesn’t appear to me.",
                                style: AppTextStyles.small(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  size: 13.sp,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      "Active",
                                      style: AppTextStyles.small(
                                        color: Colors.white,
                                        size: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF2C2A2F),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: Text(
                                      "#4394839",
                                      style: AppTextStyles.small(
                                        color: Colors.white70,
                                        size: 10,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Divider(
                height: 0,
                color: Color(0xFF231926),
              ),
              // 🕓 Date Separator
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "21Jul, 2024",
                  style: AppTextStyles.small(
                    color: Colors.white70,
                    size: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // 🧾 Chat Messages
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: [
                    // ✅ User Message
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.75,
                        ),
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.only(top: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF1E1521),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "Hi!",
                              style: AppTextStyles.small(color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Today at 02:35 pm",
                              style: AppTextStyles.small(
                                size: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // ✅ Agent Message
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 16),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const CircleAvatar(
                                radius: 14,
                                backgroundColor: Color(0xFF1C131F),
                                child: Icon(
                                  Icons.headphones_outlined,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                  constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width *
                                            0.60,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E1521),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Customer Support Agent",
                                        style: AppTextStyles.small(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow.shade600,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Divider(
                                        color: Color(0xFF251C28),
                                        thickness: 1,
                                        height: 0,
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        "Thanks for submitting your problem, we are looking into it and will let you know in shortly!",
                                        style: AppTextStyles.small(
                                          size: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "Today at 02:37 pm",
                                        style: AppTextStyles.small(
                                            size: 10, color: Colors.grey),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 💬 Input Bar
              Column(
                children: [
                  Divider(
                    height: 0,
                    color: Color(0xFF251B27),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.10,
                    decoration: BoxDecoration(color: Color(0xFF170D1A)),
                    child: InputBar(
                      onTap: () {},
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
