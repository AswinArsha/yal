import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SponsorCard extends StatelessWidget {
  final String imagePath;
  final String tier;
  final String name;

  const SponsorCard({
    super.key,
    required this.imagePath,
    required this.tier,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1923), // Dark background
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 70,
              height: 70,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                tier,
                style: AppTextStyles.small(
                  size: 14,
                  color: Color(0xFFFDEB56), // Gold-ish color
                ),
              ),
              const SizedBox(height: 4),
              Text(
                name,
                style: AppTextStyles.small(
                  size: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class SponsorsSection extends StatelessWidget {
  const SponsorsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: const [
          SponsorCard(
            imagePath: 'assets/images/bg/sponsor-image-1.png',
            tier: 'Platinum Sponsor',
            name: 'EA Sports',
          ),
          SponsorCard(
            imagePath: 'assets/images/bg/sponsor-image-2.png',
            tier: 'Gold Sponsor',
            name: 'Zeem Corporations',
          ),
          SponsorCard(
            imagePath: 'assets/images/bg/sponsor-image-3.png',
            tier: 'Bronze Sponsor',
            name: 'Saudi Dtaed',
          ),
        ],
      ),
    );
  }
}
