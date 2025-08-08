import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/nft_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/section_header.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF322A35),
              ),
              padding: const EdgeInsets.all(8),
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        title: Text(
          "MR. Beast's Collections",
          style: AppTextStyles.small(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Header Section
            // Header Section
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C121F),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/Arabian-gaming.png', // Replace with your asset path
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 12,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 22,
                          backgroundImage: AssetImage('assets/koala.png'),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Kuala",
                                style: AppTextStyles.small(
                                    size: 14,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            Text("@Kuala",
                                style: AppTextStyles.small(
                                    size: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400)),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            _socialIcon(Icons.close, context),
                            _socialIcon(Icons.discord, context),
                            _socialIcon(Icons.send, context),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Align(
              alignment: Alignment.centerLeft,
              child: Text("Description",
                  style: AppTextStyles.small(
                      size: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 8),
            Text.rich(
              TextSpan(
                text:
                    "Join the YalGamer community and become a part of an interactive space where gamers connect, share insights, and discuss their favorite games. Express your thoughts, showcase your skills. As you contribute ",
                style: AppTextStyles.small(
                    size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
                children: [
                  TextSpan(
                    text: "See more...",
                    style: AppTextStyles.small(
                        size: 12,
                        color: Color(0xFFFDEB56),
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Stats Grid
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1C121F),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildStatsRow([
                    _buildStatItem("Items", "10k"),
                    _buildStatItem("Created on", "01.01.2025"),
                    _buildStatItem("Chain", "Airbiturm"),
                    _buildStatItem("Total Volume", "81,234 Flow"),
                  ]),
                  const SizedBox(height: 4),
                  Divider(
                    color: Color(0xFF29202C),
                  ),
                  const SizedBox(height: 4),
                  _buildStatsRow([
                    _buildStatItem("Floor Price", "81,234 Flow"),
                    _buildStatItem("Best Offer", "120 Flow"),
                    _buildStatItem("Listed", "30%"),
                    _buildStatItem("Owners (Unique)", "2,340 (35%)"),
                  ]),
                ],
              ),
            ),
            Divider(
              color: Color(0xFF29202C),
            ),
            SectionHeader(title: "NFT's", onFilterPressed: () {}),
            const SizedBox(height: 12),
            NFTCard(),
            const SizedBox(height: 12),
            NFTCard(),
            const SizedBox(height: 12),
            NFTCard(),
            const SizedBox(height: 12),
            NFTCard(),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _socialIcon(IconData icon, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: CircleAvatar(
        backgroundColor: const Color(0xFF322A35),
        radius: 14,
        child: Icon(icon, color: Colors.white, size: 14),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.small(
                  size: 10, color: Colors.grey, fontWeight: FontWeight.w400)),
          const SizedBox(height: 4),
          Text(value,
              style: AppTextStyles.small(
                  size: 12, color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildStatsRow(List<Widget> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: items,
    );
  }
}
