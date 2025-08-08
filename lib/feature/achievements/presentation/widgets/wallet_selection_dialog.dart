import 'package:flutter/material.dart';
import 'package:yalgamers/feature/achievements/presentation/widgets/wallet_option_tile.dart';

class WalletSelectionDialog extends StatefulWidget {
  const WalletSelectionDialog({super.key});

  @override
  State<WalletSelectionDialog> createState() => _WalletSelectionDialogState();
}

class _WalletSelectionDialogState extends State<WalletSelectionDialog> {
  String selectedWallet = ''; // Can be 'custodial' or 'metamask'

  void _claimNFT(BuildContext context) {
    Navigator.pop(context); // Close current dialog

    // Show success dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1C1B1F),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.green,
                  child: Icon(
                    Icons.check,
                    color: Colors.black,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "NFT Claimed\nSuccessfully!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF1C121F),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Your Wallet to Claim Your NFT',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'To proceed with claiming your NFT, please\nselect the type of wallet you’d like to use:',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Custodial Wallet
            GestureDetector(
              onTap: () {
                setState(() => selectedWallet = 'custodial');
              },
              child: WalletOptionTile(
                icon: 'assets/images/logos/logo_with_name.png',
                title: 'Custodial Wallet',
                subtitle: 'Gas Free',
                address: '0x8bss.....jcbue',
                isSelected: selectedWallet == 'custodial',
                showCheckIcon: selectedWallet == 'custodial',
              ),
            ),
            const SizedBox(height: 10),

            // Metamask Wallet
            GestureDetector(
              onTap: () {
                setState(() => selectedWallet = 'metamask');
              },
              child: WalletOptionTile(
                icon: 'assets/icons/metamask-icon.png',
                title: 'Metamask Wallet',
                address: '0x8bss.....jcbue',
                isSelected: selectedWallet == 'metamask',
                showLinkIcon: true,
              ),
            ),
            const SizedBox(height: 20),

            // Claim Button
            ElevatedButton(
              onPressed:
                  selectedWallet.isNotEmpty ? () => _claimNFT(context) : null,
              child: const Text('Claim'),
              style: ElevatedButton.styleFrom(
                backgroundColor: selectedWallet.isNotEmpty
                    ? const Color(0xFF03DAC6)
                    : Colors.grey.shade800,
                disabledForegroundColor: Colors.grey,
                disabledBackgroundColor: Colors.grey.shade800,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
