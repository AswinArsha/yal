import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/marketplace/presentation/pages/collections_screen.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/membership_card.dart';
import 'package:yalgamers/feature/marketplace/presentation/widgets/section_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
          'Mr.Beasts Profile',
          style: AppTextStyles.small(
              size: 12, color: Colors.grey, fontWeight: FontWeight.w400),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(color: Color(0xFF100613)),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/beast.png'),
                    radius: 30,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Column(
                    children: [
                      Text(
                        'MR. Beast',
                        style: AppTextStyles.small(
                            size: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '@mr_beast990',
                        style: AppTextStyles.small(
                          size: 12,
                          color: Colors.white54,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF8EC9ED), // Background color
                          borderRadius: BorderRadius.circular(30), // Pill shape
                        ),
                        child: Row(
                          mainAxisSize:
                              MainAxisSize.min, // Only as wide as content
                          children: [
                            Icon(
                              Icons.location_city,
                              size: 16,
                              color: Color(0xFF1D2A33),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Saudi Arabia",
                              style: AppTextStyles.small(
                                color: Color(0xFF1D2A33),
                                size: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        height: 140, // adjust height as needed
                        child: GridView.builder(
                          itemCount: 4,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                            childAspectRatio: 2.8, // Wider boxes
                          ),
                          itemBuilder: (context, index) {
                            final items = [
                              {
                                'title': 'Influencer Since',
                                'subtitle': '12 February, 2025'
                              },
                              {'title': 'Total Posts', 'subtitle': '03'},
                              {'title': 'Total Subscribers', 'subtitle': '572'},
                              {'title': 'Total Following', 'subtitle': '91'},
                            ];
                            return titleSubtitleBox(
                              title: items[index]['title']!,
                              subtitle: items[index]['subtitle']!,
                              padding: 10,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      ActionButton(
                        onPressed: () {},
                        label: "View Main Profile",
                        color: Color(0xFF231C36),
                        textColor: Color(0xFF8D99FF),
                        arrowColor: Color(0xFF8D99FF),
                      ),
                      SizedBox(height: 5),
                      ActionButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return CollectionsScreen();
                            },
                          ));
                        },
                        label: "View Collections",
                        color: Color(0xFF311A36),
                        textColor: Color(0xFFE88DFF),
                        arrowColor: Color(0xFFE88DFF),
                      ),
                      Divider(
                        color: Color(0xFF231A26),
                      ),
                      SectionHeader(
                        title: "Memberships by MR. Beast",
                        onFilterPressed: () {},
                      ),
                      const SizedBox(height: 12),
                      MembershipCard(),
                      const SizedBox(height: 12),
                      MembershipCard(),
                      const SizedBox(height: 12),
                      MembershipCard(),
                      const SizedBox(height: 12),
                      MembershipCard(),
                      const SizedBox(height: 12),
                      MembershipCard(),
                      const SizedBox(height: 12),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleSubtitleBox({
    required String title,
    required String subtitle,
    Color backgroundColor = const Color(0xFF19101C),
    Color titleColor = Colors.white60,
    Color subtitleColor = Colors.white,
    double borderRadius = 8,
    double padding = 14,
  }) {
    return Container(
      height: 60,
      width: 150,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.small(
              color: titleColor,
              size: 10,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTextStyles.small(
              color: subtitleColor,
              size: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final Color arrowColor;
  final VoidCallback onPressed;

  ActionButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.arrowColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: AppTextStyles.medium(
                color: textColor,
                size: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: arrowColor,
            ),
          ],
        ),
      ),
    );
  }
}
