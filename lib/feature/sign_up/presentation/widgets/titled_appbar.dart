import 'package:flutter/material.dart';

import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class TitleAppbar extends StatelessWidget {
  final String subtitle;
  final String title;
  const TitleAppbar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1C121F),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white10,
                radius: 20,
                child: BackButton(color: Colors.white),
              )
            ],
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: AppTextStyles.medium(
              size: 24,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            subtitle,
            style: AppTextStyles.small(
              size: 14,
              color: const Color.fromARGB(150, 255, 255, 255),
            ),
          ),
        ],
      ),
    );
  }
}
