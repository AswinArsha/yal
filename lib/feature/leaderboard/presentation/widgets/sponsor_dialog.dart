import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class TournamentDialog extends StatefulWidget {
  const TournamentDialog({super.key});

  @override
  TournamentDialogState createState() => TournamentDialogState();
}

class TournamentDialogState extends State<TournamentDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(28, 18, 31, 1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with timer and close button

            // Diamond Sponsor
            Text(
              'Diamond Sponsor',
              style: AppTextStyles.largeBold(
                color: AppColors.baseWhite.withOpacity(0.9),
                size: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Image.asset('assets/images/logos/pubg.png',
                height: 60.h, width: 60.w),
            const SizedBox(height: 24),

            // Participating Sponsors
            Text(
              'Participating Sponsors',
              style: AppTextStyles.largeBold(
                color: AppColors.baseWhite.withOpacity(0.9),
                size: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 6,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Image.asset('assets/images/logos/pubg.png',
                    height: 37.h, width: 37.w);
              },
            ),
          ],
        ),
      ),
    );
  }
}
