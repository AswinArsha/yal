import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/core/theme/app_colors.dart';

class PubgUcCard extends StatelessWidget {
  const PubgUcCard({super.key});

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
                    'assets/pubg_card.png',
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(top: 6),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 12,
                        backgroundColor: Color(0xFF2B2235),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Image(
                            image: AssetImage('assets/icons/flash.png'),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PUBG UC',
                  style: AppTextStyles.medium(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    size: 14,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  'Min buy 1000 UC',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
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
                icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                label: const Text('Buy Now'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6B7AFF),
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
