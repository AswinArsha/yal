import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart' show AppColors;
import 'package:yalgamers/core/theme/text_style.dart';

Widget RewardBox(
  BuildContext context, {
  required String title,
  required String value,
  required IconData icon,
  required Color color,
  required Color tileColor,
}) {
  return Container(
    decoration: BoxDecoration(
      color: tileColor,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Padding(
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: color.withOpacity(0.2),
              border: Border.all(
                color: color.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Icon(icon, size: 24.h, color: color),
          ),
          SizedBox(width: 8.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.6),
                  fontWeight: FontWeight.w400,
                  size: 12,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: AppTextStyles.largeBold(
                  color: AppColors.xpColor,
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
