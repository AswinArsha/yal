import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

Container spinWheelCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: const Color(0xFFBC5AD7),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Stack(
      children: [
        // Main Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Earning XP and Tickets \nby daily spin.',
              textAlign: TextAlign.left,
              style: AppTextStyles.largeBold(
                size: 20.sp,
                color: const Color.fromRGBO(34, 18, 38, 1),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'You can earn more XP and Tickets by playing daily spin.',
              style: AppTextStyles.medium(
                color: const Color.fromRGBO(34, 18, 38, 0.8),
                fontWeight: FontWeight.w400,
                size: 14.sp,
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                backgroundColor: const Color.fromRGBO(34, 18, 38, 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              ),
              onPressed: () {},
              child: Text(
                'Play Now',
                style: AppTextStyles.mediumBold(
                  color: AppColors.baseWhite,
                  fontWeight: FontWeight.w500,
                  size: 14.sp,
                ),
              ),
            ),
          ],
        ),

        // Bottom-right image
        Positioned(
          bottom: 0,
          right: 0,
          child: Image.asset(
            'assets/images/bg/spin_wheel.png', // Replace with your actual image path
            width: 100.w, // Adjust size responsively if needed
            height: 100.h,
          ),
        ),
      ],
    ),
  );
}
