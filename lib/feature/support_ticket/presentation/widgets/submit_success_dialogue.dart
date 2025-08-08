import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/constants/common_widgets/green_check_icon.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SubmitSuccessDialog extends StatelessWidget {
  final VoidCallback onGoToChat;
  final VoidCallback onBackToHome;

  const SubmitSuccessDialog({
    super.key,
    required this.onGoToChat,
    required this.onBackToHome,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1C121F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ✅ Green Check Icon
            GreenCheckIcon(),

            const SizedBox(height: 24),

            // ✅ Success Text
            Text(
              "Your Ticket Submitted\nSuccessfully!",
              textAlign: TextAlign.center,
              style: AppTextStyles.small(
                size: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 24),

            // ✅ Go to Chat Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF322725),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onPressed: onGoToChat,
                icon: Image.asset(
                  'assets/icons/chat.png', // 🖼️ Your local image path
                  width: 20,
                  height: 20,
                  color: Colors.yellow,
                ),
                label: Text(
                  "Go to Chat",
                  style: AppTextStyles.small(color: Colors.yellow),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // ✅ Back to Home Button
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFF2E2531),
                borderRadius: BorderRadius.circular(6), // 👈 Add this line
              ),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: Color(0xFF39303C)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  foregroundColor: Colors.white,
                ),
                onPressed: onBackToHome,
                child: Text(
                  "Back to Home",
                  style: AppTextStyles.small(color: AppColors.baseWhite),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
