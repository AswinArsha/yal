import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/marketplace/presentation/pages/sponsors_screen.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/creator_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/membership_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/nft_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/pubg_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/section_header.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0), // Optional: for spacing
          child: GestureDetector(
            onTap: () {
              // Handle back navigation
            },
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF322A35), // You can change the background color
              ),
              padding:
                  const EdgeInsets.all(8), // Size of the icon inside the circle
              child:
                  const Icon(Icons.arrow_back, color: Colors.white, size: 20),
            ),
          ),
        ),
        title: Text(
          'Marketplace',
          style: AppTextStyles.small(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                // My Purchased Items aligned to top right
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(
                    height: 32, // ← Set your desired height here
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.shopping_bag_outlined, size: 16),
                      label: const Text('My Purchased Items'),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            const Color(0x268EC9ED), // 15% transparent
                        foregroundColor: const Color(0xFF8EC9ED),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        textStyle: AppTextStyles.small(
                          size: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                            color: Color(0x1A8EC9ED), // 10% transparent border
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Popular Collections Now + Filter
                SectionHeader(
                  title: "Popular Collections Now",
                  onFilterPressed: () {},
                )
              ],
            ),
            const SizedBox(height: 12),
            const CreatorCard(),
            const SizedBox(height: 12),
            const CreatorCard(),
            const SizedBox(height: 12),
            const NFTCard(),
            const SizedBox(height: 12),
            const NFTCard(),
            const SizedBox(height: 12),
            const PubgUcCard(),
            const SizedBox(height: 12),
            const PubgUcCard(),
            const SizedBox(height: 12),
            SectionHeader(
              title: "Memberships",
              onFilterPressed: () {},
              subtitle: "Explore memberships by our influencers ",
            ),
            const SizedBox(height: 12),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const SponsorsScreen();
                    },
                  ));
                },
                child: const MembershipCard()),
            const SizedBox(height: 12),
            const MembershipCard(),
            const SizedBox(height: 12),
            const MembershipCard(),
            const SizedBox(height: 12),
            const MembershipCard(),
            const SizedBox(height: 12),
            SectionHeader(
              title: "NFT's",
              onFilterPressed: () {},
            ),
            const SizedBox(height: 12),
            const NFTCard(),
            const SizedBox(height: 12),
            const NFTCard(),
            const SizedBox(height: 12),
            const NFTCard(),
            const SizedBox(height: 12),
            const NFTCard(),
          ],
        ),
      ),
    );
  }
}
