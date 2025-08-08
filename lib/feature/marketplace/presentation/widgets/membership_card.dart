import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class MembershipCard extends StatelessWidget {
  const MembershipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1C131F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF322A35), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📸 Banner Image + Label
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    'assets/mr_beast_card.png',
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2C3A40),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icons/flash.png',
                          height: 12,
                          width: 12,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Popular Now',
                          style: AppTextStyles.small(
                            color: const Color(0xFFA8EAFF),
                            size: 12,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // 📰 Title + Subs + Price
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title & Subs
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'News About Our Sponsors',
                        style: AppTextStyles.medium(
                          color: Colors.white,
                          size: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '2.23k Subscribers',
                        style: AppTextStyles.small(
                          color: Colors.white60,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Price
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$40 USDT',
                      style: AppTextStyles.small(
                        color: const Color(0xFFFDEB56),
                        fontWeight: FontWeight.w500,
                        size: 12,
                      ),
                    ),
                    Text(
                      '/ 2 ETH',
                      style: AppTextStyles.small(
                        color: const Color(0xFFFDEB56),
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),

          // Divider
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Divider(
              color: const Color(0xFF322A35),
              thickness: 1,
            ),
          ),

          // 👤 Creator Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 16,
                  backgroundImage: AssetImage('assets/beast.png'),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'MR. Beast',
                      style: AppTextStyles.small(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        size: 14,
                      ),
                    ),
                    Text(
                      '@mr_beast990',
                      style: AppTextStyles.small(
                        color: Colors.white60,
                        size: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
