import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/send_screen.dart';

class DepositScreen extends StatelessWidget {
  const DepositScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const String walletAddress = '0x8c5...8Vfe7';

    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C121F),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Deposit',
          style: AppTextStyles.small(
            color: Colors.grey,
            size: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Title
            Text(
              'Deposit',
              style: AppTextStyles.small(
                color: Colors.white,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),

            // Warning Text
            Text(
              'Please deposit only USDT or POL to this wallet address. Depositing any other assets may result in a loss of funds, which cannot be recovered.',
              style: AppTextStyles.small(
                color: Colors.grey,
                size: 12,
              ),
            ),
            const SizedBox(height: 12),

            // Disclaimer
            Text(
              '*Yagamers will be not responsible for that.',
              style: AppTextStyles.small(
                color: Colors.red,
                size: 10,
              ),
            ),

            // QR Code Image
            const SizedBox(height: 30),
            Center(
              child: Container(
                width: 240,
                height: 240,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2B3A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: const Color(0xFF3A3448),
                    width: 1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/qr-code.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),

            // Wallet Address
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Wallet Address: ',
                  style: AppTextStyles.small(
                    color: Color(0xFFFFD700),
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Text(
                  walletAddress,
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(width: 8),
                InkWell(
                  onTap: () {
                    Clipboard.setData(ClipboardData(text: walletAddress));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Wallet address copied!'),
                        backgroundColor: Color(0xFF4CAF50),
                      ),
                    );
                  },
                  child: Icon(
                    Icons.copy,
                    color: Colors.grey[400],
                    size: 18,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Done Button
            PrimaryButton(
              label: "Done",
              textColor: AppColors.background,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return SendScreen();
                  },
                ));
              },
              gradient: buttonGradience(),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
