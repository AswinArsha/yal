
import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
class ReferallCard extends StatelessWidget {
  const ReferallCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(
            0xFF86CBF8), // or use a similar blue shade
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Refer to earn more XP!",
            style: AppTextStyles.medium(
              size: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF112D3A),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            "Refer your friends to earn\nmore xp and tickets.",
            style: AppTextStyles.medium(
              color: const Color(0xFF2F4858),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF193241),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: Text(
                  "Refer Now",
                  style: AppTextStyles.small(
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.copy, color: Color(0xFF2F4858)),
              const SizedBox(width: 6),
              Text(
                "Copy Refer Code",
                style: AppTextStyles.small(
                  color: const Color(0xFF2F4858),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
