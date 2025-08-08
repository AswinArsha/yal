import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/core/theme/app_colors.dart';

class NFTCard extends StatelessWidget {
  const NFTCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C131F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF322A35),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/koala.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF2B2235),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: Image.asset(
                      'assets/icons/flash.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BEAST NFT',
                        style: AppTextStyles.medium(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          size: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      const Text(
                        '#323239',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '2 ETH',
                      style: AppTextStyles.small(
                        color: const Color(0xFFFDEB56),
                        fontWeight: FontWeight.w500,
                        size: 14,
                      ),
                    ),
                    Text(
                      '/ 2 USDT',
                      style: AppTextStyles.medium(
                        color: Colors.white60,
                        size: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.visibility_outlined, size: 16),
                label: const Text('View Collection'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB659FF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  textStyle: AppTextStyles.small(
                    size: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.baseWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
