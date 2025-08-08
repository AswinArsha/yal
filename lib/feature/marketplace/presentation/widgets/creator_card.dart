import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class CreatorCard extends StatelessWidget {
  const CreatorCard({super.key});

  Widget _pill(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: AppTextStyles.small(
            color: Colors.white, size: 10, fontWeight: FontWeight.w400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF170B1F),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2C1840),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Image.asset(
                  'assets/icons/stars.png',
                  width: 20,
                  height: 20,
                ),
              ),
              const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage('assets/beast.png'),
              ),
              Text(
                'MR. Beast',
                style: AppTextStyles.medium(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  size: 16,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '@mr_beast990',
                style: AppTextStyles.small(
                  color: Colors.white60,
                  size: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _pill('5.7k Subscribers', const Color(0xFF291E31)),
              const SizedBox(width: 8),
              _pill('3 Items', const Color(0xFFA167FF)),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF8EC9ED),
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'View Profile',
                style: AppTextStyles.small(
                  fontWeight: FontWeight.w600,
                  size: 12,
                  color: const Color(0xFF172229),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
