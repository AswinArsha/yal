
import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

Widget portalTile({
  required Color borderColor,
  required Color tileColor,
  required String imagePath,
  required Color iconBgColor,
  required String title,
  required String subtitle,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: isSelected ? tileColor.withOpacity(0.8) : tileColor,
        borderRadius: BorderRadius.circular(12),
        border: isSelected ? Border.all(color: borderColor, width: 1) : null,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(imagePath, height: 32, width: 32),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.mediumBold(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        size: 16)),
                const SizedBox(height: 4),
                Text(subtitle,
                    style: AppTextStyles.small(
                        color: Colors.white70,
                        fontWeight: FontWeight.w400,
                        size: 12)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
