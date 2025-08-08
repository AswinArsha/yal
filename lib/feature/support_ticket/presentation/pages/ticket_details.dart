import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/game_section/presentation/widgets/arrow_back.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
import 'package:yalgamers/feature/support_ticket/presentation/pages/support_chat_screen.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({super.key});

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
        title: Text(
          'Your Ticket Details',
          style: AppTextStyles.medium(
            fontWeight: FontWeight.w400,
            size: 12.sp,
            color: AppColors.baseWhite.withOpacity(0.4),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'My Ticket',
                  style: AppTextStyles.mediumBold(
                      size: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.baseWhite.withOpacity(0.9)),
                ),
                const LuminousCard(
                    luminousColor: Colors.grey, label: '#4394839')
              ],
            ),
            const SizedBox(height: 16),
            Image.asset('assets/images/bg/ticket_web.png'),
            const SizedBox(height: 16),
            Text(
              'My XP points are not adding.',
              style: AppTextStyles.largeBold(
                  size: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.baseWhite.withOpacity(0.9)),
            ),
            const SizedBox(height: 10),
            Text(
              overflow: TextOverflow.visible,
              "Lorem ipsum dolor sit amet consectetur. Sed volutpat aliquam fusce sit id feugiat eget. Erat proin iaculis scelerisque diam aenean cursus integer at euismod. Auctor tempus adipiscing sociis erat tellus habitasse suscipit ut fames. Vehicula pulvinar mattis blandit molestie phasellus non id.Lorem ipsum dolor sit amet consectetur. Sed volutpat aliquam fusce sit id feugiat eget. Erat proin iaculis scelerisque diam aenean cursus integer at euismod. Auctor tempus adipiscing sociis erat tellus habitasse suscipit ut fames. Vehicula pulvinar mattis blandit molestie phasellus non id.",
              style: AppTextStyles.largeBold(
                  size: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.baseWhite.withOpacity(0.5)),
            ),
            const SizedBox(height: 18),
            Text(
              "Created on 01 January, 2024.",
              style: AppTextStyles.largeBold(
                  size: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.baseWhite.withOpacity(0.4)),
            ),
            const SizedBox(height: 100), // Give space for bottom bar
          ],
        ),
      ),

      /// 🔽 Persistent Bottom Buttons
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.baseWhite.withOpacity(0.08))),
          color: const Color.fromRGBO(
              255, 255, 255, 0.06), // Background color of bottom section
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SupportChatScreen();
                  },
                ));
              },
              child: Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color(0xFF2E2320)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(height: 18.h, 'assets/icons/chat_color.png'),
                    const SizedBox(width: 10),
                    Text(
                      'Chat',
                      style: AppTextStyles.large(
                          fontWeight: FontWeight.w600,
                          size: 16.sp,
                          color: AppColors.xpColor),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            PrimaryButton(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              textColor: AppColors.baseWhite.withOpacity(0.9),
              prefixIcon: Icons.check,
              iconColor: Colors.white,
              label: 'Problem Solved',
              onPressed: () {
                ticketDialog(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future<dynamic> ticketDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierColor: AppColors.baseWhite.withOpacity(0.06), // dark background
    builder: (context) {
      return AlertDialog(
        backgroundColor:
            const Color.fromRGBO(28, 19, 31, 1), // dark dialog background
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Text(
          overflow: TextOverflow.visible,
          "Are you sure you want to close this ticket?",
          style: AppTextStyles.largeBold(
            size: 18.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.baseWhite.withOpacity(0.9),
          ),
        ),
        content: Text(
          overflow: TextOverflow.visible,
          'Close tickets if only your problem’s are solved, otherwise if your problem is not solved then you have to create a new ticket.',
          style: AppTextStyles.medium(
            size: 12.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.baseWhite.withOpacity(0.7),
          ),
        ),
        actions: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => showSuccessDialog(
                    context,
                    'Ticket Closed Successfully!',
                    'Your ticket was successfully closed.',
                    ''),
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFF1FD031).withOpacity(0.1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        size: 20.h,
                        Icons.check_circle,
                        color: const Color(0xFF1FD031),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Yes, Problem Solved',
                        style: AppTextStyles.large(
                            fontWeight: FontWeight.w500,
                            size: 14.sp,
                            color: const Color(0xFF1FD031)),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color(0xFFF71756).withOpacity(0.1)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      size: 20.h,
                      Icons.highlight_remove,
                      color: const Color(0xFFF71756),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      'Not Solved, Still Close!',
                      style: AppTextStyles.large(
                          fontWeight: FontWeight.w500,
                          size: 14.sp,
                          color: const Color(0xFFF71756)),
                    )
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              PrimaryButton(label: 'Cancel', onPressed: () {})
            ],
          ),
        ],
      );
    },
  );
}
