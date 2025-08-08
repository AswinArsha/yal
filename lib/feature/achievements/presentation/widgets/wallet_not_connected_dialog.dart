import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class WalletNotConnectedDialog extends StatelessWidget {
  const WalletNotConnectedDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1C121F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      contentPadding: const EdgeInsets.all(20),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Choose Your Wallet to\nClaim Your NFT",
            textAlign: TextAlign.center,
            style: AppTextStyles.small(
              size: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "To proceed with claiming your NFT,\nplease select the type of wallet you’d like to use:",
            textAlign: TextAlign.center,
            style: AppTextStyles.small(
              size: 12,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          _walletOption("assets/images/logos/logo_with_name.png",
              "Custodial Wallet (Gas Free)", "0x8bss.....jcbue",
              disabled: true),
          const SizedBox(height: 8),
          _walletOption("assets/icons/metamask-icon.png", "Metamask Wallet",
              "0x8bss.....jcbue",
              disabled: true),
          const SizedBox(height: 16),
          Text(
            "Wallet Not Connected!",
            style: AppTextStyles.small(
              size: 12,
              color: Colors.redAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pop(context);
              // add connect wallet logic here
            },
            icon: const Icon(Icons.add, color: Colors.black, size: 16),
            label: Text(
              "Connect Wallet First",
              style: AppTextStyles.small(
                size: 14,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFE55E),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _walletOption(String iconPath, String title, String address,
      {bool disabled = false}) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(iconPath, height: 24, width: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.small(
                    size: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Wallet Address: $address",
                  style: AppTextStyles.small(
                    size: 10,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          if (disabled) const Icon(Icons.lock, size: 16, color: Colors.white38),
        ],
      ),
    );
  }
}
