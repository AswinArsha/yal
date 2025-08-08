import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/find_players/presentation/widgets/solid_button.dart';

Container rewardPosterCard(
  String colorText,
  String title,
  String label,
  String count,
  Color buttonColor,
  String buttonText,
  void Function()? onPressed,
  Widget animationWidget,
  String bgImage, // Add this parameter
) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: AppColors.baseWhite.withOpacity(0.03),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.baseWhite.withOpacity(0.05)),
    ),
    child: Stack(
      children: [
        // 🌟 Softly Fading Big Ray (blur/fade edges)
        Positioned(
          bottom: 0,
          right: 0,
          child: Container(
            width: 280.w,
            height: 280.h,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage(bgImage),
                fit: BoxFit.cover,
                opacity: 0.7, // adjust fade level
              ),
            ),
          ),
        ),

        // 🌟 Main Content
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [
                        Color(0xFFF71756),
                        Color(0xFFFDEB56),
                      ],
                    ).createShader(
                        Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      colorText,
                      style: AppTextStyles.medium(
                        size: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: AppTextStyles.medium(
                      size: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 130.h,
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4, horizontal: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: AppColors.baseWhite.withOpacity(0.04)),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: label,
                                  style: AppTextStyles.medium(
                                    size: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.baseWhite.withOpacity(0.7),
                                  ),
                                ),
                                TextSpan(
                                  text: count,
                                  style: AppTextStyles.medium(
                                    size: 12.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SolidButton(
                          width: 120.w,
                          height: 37.h,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          onPressed: onPressed,
                          label: buttonText,
                          buttonColor: buttonColor,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                      child:
                          animationWidget), // Use the passed animation widget
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
