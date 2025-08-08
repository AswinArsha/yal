import 'package:flutter/material.dart';

class WalletOptionTile extends StatelessWidget {
  final String icon;
  final String title;
  final String? subtitle;
  final String address;
  final bool showLinkIcon;
  final bool showCheckIcon;
  final bool isSelected;

  const WalletOptionTile({
    super.key,
    required this.icon,
    required this.title,
    required this.address,
    this.subtitle,
    this.showLinkIcon = false,
    this.showCheckIcon = false,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0x1A00FF00) // Green transparent
            : const Color(0xFF322A35),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? Colors.green : Colors.transparent,
          width: 2,
        ),
      ),
      child: Row(
        children: [
          Image.asset(icon, width: 32, height: 32),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(width: 6),
                      Text(
                        '($subtitle)',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ]
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'Wallet Address: $address',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          if (showCheckIcon)
            const Icon(Icons.check_circle, color: Colors.green, size: 18),
          if (showLinkIcon)
            const Icon(Icons.link, color: Colors.pinkAccent, size: 18),
        ],
      ),
    );
  }
}
