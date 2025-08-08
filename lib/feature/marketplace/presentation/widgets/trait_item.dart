import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class TraitItem extends StatelessWidget {
  final String title;
  final String value;
  final String badgeText;
  final Color badgeColor;

  const TraitItem({
    super.key,
    required this.title,
    required this.value,
    required this.badgeText,
    required this.badgeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF272B32),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.small(
                  color: Colors.white60,
                  size: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: AppTextStyles.small(
                  color: Colors.white,
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: badgeText,
                        style: AppTextStyles.small(
                          color: Colors.white,
                          size: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const TextSpan(
                        text: ' 31%',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '3.424 ',
                      style: AppTextStyles.small(
                        color: Colors.white,
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: 'SOL',
                      style: AppTextStyles.small(
                        color: Colors.white54,
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
