import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/marketplace/presentation/pages/profile_screen.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/benefit_row.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/detail_item.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/trait_item.dart';

class SponsorsScreen extends StatefulWidget {
  const SponsorsScreen({super.key});

  @override
  State<SponsorsScreen> createState() => _SponsorsScreenState();
}

class _SponsorsScreenState extends State<SponsorsScreen> {
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
          'News About Our Sponsors',
          style: AppTextStyles.small(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sponsor Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                    'assets/mr_beast_card.png'), // Replace with your image
              ),
              const SizedBox(height: 16),

              // Title and price
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'News About Our Sponsors',
                    style: AppTextStyles.small(
                        size: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$40 USDT',
                    style: AppTextStyles.medium(
                      size: 14,
                      color: const Color(0xFFFDEB56),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Subtitle
              Text(
                'You will get news and updates about our sponsors by subscribing us.',
                style: AppTextStyles.small(
                    size: 12,
                    color: const Color(0xFFB7B4B8),
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 16),

              // Profile card
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                    color: const Color(0xFF1C1929),
                    borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundImage: AssetImage('assets/beast.png'),
                      radius: 20,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MR. Beast',
                            style: AppTextStyles.small(
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            '@mr_beast990',
                            style: AppTextStyles.small(
                              size: 12,
                              color: Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const ProfileScreen();
                          },
                        ));
                      },
                      child: Row(
                        children: [
                          Text(
                            'View Profile',
                            style: AppTextStyles.small(
                              size: 12,
                              color: const Color(0xFF8EC9ED),
                            ),
                          ),
                          const Icon(Icons.arrow_forward_ios,
                              size: 12, color: Color(0xFF8EC9ED)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Divider(
                  color: Color(0xFF322A35),
                  thickness: 1,
                ),
              ),
              // More Details
              Text(
                'More Details',
                style: AppTextStyles.small(
                    size: 14, color: Colors.white, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Text.rich(
                TextSpan(
                  text:
                      'Join the YaIGamer community and become a part of an interactive space where gamers connect, share insights, and discuss their favorite games. Express your thoughts, showcase your skills, and engage in ',
                  style: AppTextStyles.small(
                      size: 12,
                      color: const Color(0xFF888389),
                      fontWeight: FontWeight.w400),
                  children: [
                    TextSpan(
                      text: 'See more...',
                      style: AppTextStyles.small(
                        size: 12,
                        color: const Color(0xFFFDEB56),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Benefits Card
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1C121F),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Benefits',
                      style: AppTextStyles.small(
                          size: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 12),
                    const BenefitRow(
                      text: 'The ability to post and engage in discussions.',
                    ),
                    const BenefitRow(
                      text: 'Special recognition as a Yalgamers Influencer.',
                    ),
                    const BenefitRow(
                      text:
                          'Exclusive perks, rewards, and early access to platform features.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Traits Section
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1E25),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.shield_outlined,
                            color: Color(0xFF6EE8B6), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Traits',
                          style: AppTextStyles.small(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            size: 14,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_up,
                            color: Color(0xFF77F3BF)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const TraitItem(
                      title: 'Class',
                      value: 'Warrior',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFF1FD031),
                    ),
                    const TraitItem(
                      title: 'Race',
                      value: 'Human',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFF32363C),
                    ),
                    const TraitItem(
                      title: 'Background',
                      value: 'Blue',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFFF71756),
                    ),
                    const TraitItem(
                      title: 'Skin',
                      value: 'Tan',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFF8EC9ED),
                    ),
                    const TraitItem(
                      title: 'Body',
                      value: 'Branded Mail',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFF32363C),
                    ),
                    const TraitItem(
                      title: 'Head',
                      value: 'Monster Helmet',
                      badgeText: '3.5k 31%',
                      badgeColor: Color(0xFFF71756),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
// Details Section
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF20132A),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.grid_view_rounded,
                            color: Color(0xFFB588FF), size: 18),
                        const SizedBox(width: 8),
                        Text(
                          'Details',
                          style: AppTextStyles.small(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            size: 14,
                          ),
                        ),
                        const Spacer(),
                        const Icon(Icons.keyboard_arrow_up,
                            color: Color(0xFFB588FF)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const DetailItem(
                      title: 'Asset ID',
                      value: '1e93dh..3r84fd4fdde',
                    ),
                    const DetailItem(
                      title: 'Owner',
                      value: 'dmeijd39.....e3dh3e',
                    ),
                    const DetailItem(
                      title: 'On Chain Collection',
                      value: 'e2dn4.....4fd94ed',
                    ),
                    const DetailItem(
                      title: 'Token Standard',
                      value: 'Metaplex Core NFT',
                    ),
                    const DetailItem(
                      title: 'Royalties',
                      value: '5%',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
        Positioned(
          bottom: 16,
          left: 16,
          right: 16,
          child: SizedBox(
              width: double.infinity,
              child: PrimaryButton(
                label: "Register Now",
                onPressed: () {
                  showPaymentDialog(context);
                },
                gradient: buttonGradience(),
                textColor: const Color(0xFF25220B),
              )),
        ),
      ]),
    );
  }

  void showPaymentDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        int? selectedIndex;

        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1C121F),
                      borderRadius: BorderRadius.circular(6),
                      border:
                          Border.all(color: const Color(0xFF251B28), width: 2),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Select Payment Option",
                            style: AppTextStyles.medium(
                              size: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Payment Option Tiles
                        _paymentOptionTile(
                          index: 0,
                          selectedIndex: selectedIndex,
                          icon: 'assets/icons/pay-yalgamers.png',
                          title: 'Pay With Custodial Wallet',
                          subtitle:
                              'Pay With the Wallet You Added to Yalgamers.',
                          onTap: () => setState(() => selectedIndex = 0),
                        ),
                        const SizedBox(height: 10),
                        _paymentOptionTile(
                          index: 1,
                          selectedIndex: selectedIndex,
                          icon: 'assets/icons/pay-metamask.png',
                          title: 'Pay With Metamask Wallet',
                          subtitle:
                              'Pay With the Wallet You Added to Yalgamers.',
                          onTap: () => setState(() => selectedIndex = 1),
                        ),
                        const SizedBox(height: 10),
                        _paymentOptionTile(
                          index: 2,
                          selectedIndex: selectedIndex,
                          icon: 'assets/icons/pay-credit-card.png',
                          title: 'Pay With Card',
                          subtitle:
                              'Pay With the Wallet You Added to Yalgamers.',
                          onTap: () => setState(() => selectedIndex = 2),
                        ),
                        const SizedBox(height: 20),

                        // Next Button
                        Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: selectedIndex != null
                                ? const Color(0xFF8EC9ED) // Activated color
                                : const Color(0xFF322935),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextButton(
                            onPressed: selectedIndex != null
                                ? () {
                                    Navigator.of(context)
                                        .pop(); // Close the payment dialog
                                    showSuccessDialog(
                                        context); // Show the success dialog
                                  }
                                : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Next',
                                    style: TextStyle(color: Colors.white)),
                                SizedBox(width: 8),
                                Icon(Icons.arrow_forward, color: Colors.white),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Close Button
                  Positioned(
                    top: -14,
                    right: -14,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const CircleAvatar(
                        radius: 14,
                        backgroundColor: Colors.white12,
                        child: Icon(Icons.close, color: Colors.white, size: 18),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _paymentOptionTile({
    required int index,
    required int? selectedIndex,
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final isSelected = selectedIndex == index;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1C121F),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: isSelected ? const Color(0xFF00C566) : Colors.white12,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFF322935),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Image.asset(icon),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: AppTextStyles.small(
                        size: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      )),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: AppTextStyles.small(
                        color: Colors.white70,
                        size: 10,
                        fontWeight: FontWeight.w400,
                      )),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle,
                  color: Color(0xFF00C566)), // green tick
          ],
        ),
      ),
    );
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true, // prevent accidental dismiss
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF1C121F),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green tick circle
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF1D2E21),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.check_circle,
                    color: Color(0xFF1FD031),
                    size: 90,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  "Purchased Successfully!",
                  style: AppTextStyles.small(
                    size: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  "You successfully purchased the\nsubscription of MR. Beast.",
                  style: AppTextStyles.small(
                    size: 14,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
