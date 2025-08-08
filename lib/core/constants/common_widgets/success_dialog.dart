
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yalgamers/core/theme/app_colors.dart';

void showSuccessDialog(context, String title, String subtitle, String xp) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Dialog(
      backgroundColor: const Color(0xFF1C121F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage('assets/icons/check_mark.png')),
                color: Colors.green.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Reward',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                          color: AppColors.baseWhite.withOpacity(0.4)),
                    )),
                const SizedBox(width: 8),
                Image.asset('assets/icons/xp-icon.png'),
                const SizedBox(width: 8),
                Container(
                  width: 2,
                  height: 12.h,
                  color:
                      AppColors.baseWhite.withOpacity(0.1), // Customize color
                ),
                const SizedBox(width: 8),
                Text(xp,
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          color: AppColors.xpColor),
                    ))
              ],
            ),
          ],
        ),
      ),
    ),
  );

  Future.delayed(const Duration(seconds: 2), () {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  });
}
