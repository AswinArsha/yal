import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard functionality
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/deposit_screen.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/history_screen.dart'; // Added import for AppTextStyles

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1320), // Dark background color
      appBar: AppBar(
        backgroundColor:
            const Color(0xFF1A1320), // Same as background for seamless look
        elevation: 0, // No shadow
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2B3A),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),
        ),
        title: Text(
          'Wallet',
          style: AppTextStyles.small(
            color:
                Colors.white, // Changed to white to match the original design
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Network Selection Tabs
            _buildNetworkTabs(),
            const SizedBox(height: 20),

            // My Wallet Section
            _buildMyWalletCard(context),
            const SizedBox(height: 15),
            Divider(
              color: Color.fromARGB(255, 80, 74, 83),
            ),
            // My Balance Section
            Text(
              'My Balance',
              style: AppTextStyles.small(
                color: Colors.white,
                size: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            _buildMyBalanceSection(),
            const SizedBox(height: 20),

            // Send / Deposit Buttons
            _buildActionButtons(context),
            const SizedBox(height: 30),

            // Other Wallets Section
            Text(
              'Other Wallets',
              style: AppTextStyles.small(
                color: Colors.white,
                size: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 15),
            _buildOtherWalletItem(
              image: 'assets/icons/solona-logo.png',
              icon: Icons.currency_bitcoin, // Placeholder for Solana icon
              walletName: 'Solona',
              walletAddress: '0x8c5...8Vfe7',
              isConnected: true,
              onActionPressed: () {
                // Handle disconnect for Solana
              },
            ),
            const SizedBox(height: 10),
            _buildOtherWalletItem(
              image: 'assets/icons/Ronin.png',
              icon: Icons.account_balance_wallet, // Placeholder for Ronin icon
              walletName: 'Ronin',
              isConnected: false,
              onActionPressed: () {
                // Handle connect for Ronin
              },
            ),
            const SizedBox(height: 10),
            _buildOtherWalletItem(
              image: 'assets/icons/metamask-icon.png',
              icon:
                  Icons.account_balance_wallet, // Placeholder for Metamask icon
              walletName: 'Metamask',
              isConnected: false,
              onActionPressed: () {
                // Handle connect for Metamask
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNetworkTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2B3A),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF4A4458), // Selected tab - lighter
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Arbitrum logo placeholder
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.hexagon,
                        color: Colors.white, size: 12),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Arbitrum',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Polygon logo placeholder
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.purple,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.link, color: Colors.white, size: 12),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Polygon',
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

// Helper method to build "My Wallet" card
  Widget _buildMyWalletCard(BuildContext context) {
    const String walletAddress = '0x8c5...8Vfe7';

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1825), // Darker background matching the image
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2D2B3A), // Subtle border
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // App logo/icon
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Color(0xFF272231),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/logos/app-logo.png',
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Wallet info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Wallet',
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.folder_outlined,
                      color:
                          Color(0xFFFDEB56), // Yellow color matching the image
                      size: 16,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Wallet Address: ',
                      style: AppTextStyles.small(
                        color: Color(0xFFFFD700), // Yellow color
                        size: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        walletAddress,
                        style: AppTextStyles.small(
                          color: Colors.white,
                          size: 12,
                          fontWeight: FontWeight.w400,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Copy and refresh buttons
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  Clipboard.setData(const ClipboardData(text: walletAddress));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Wallet address copied!')),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.copy,
                    color: Colors.grey[400],
                    size: 16,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              InkWell(
                onTap: () {
                  // Handle refresh
                },
                child: Container(
                  padding: const EdgeInsets.all(4),
                  child: Icon(
                    Icons.refresh,
                    color: Colors.grey[400],
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper method to build "My Balance" section
  Widget _buildMyBalanceSection() {
    return Row(
      children: [
        Expanded(
          child: _buildBalanceCard(
            label: 'USDT Balance:',
            balance: '\$100',
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: _buildBalanceCard(
            label: 'ETH Balance:',
            balance: '\$00',
          ),
        ),
      ],
    );
  }

  // Helper method to build individual balance card
  Widget _buildBalanceCard({required String label, required String balance}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF211824), Color(0xFF160C19)],
          stops: [0.0, 1],
        ), // Card background color
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.small(color: Colors.grey, size: 14),
          ),
          const SizedBox(height: 5),
          Text(
            balance,
            style: AppTextStyles.small(
              color: Colors.white,
              size: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build Send/Deposit buttons
  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return HistoryScreen();
                },
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF8EC9ED), // Blue button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            icon:
                const Icon(Icons.arrow_outward_sharp, color: Color(0xFF1F2D35)),
            label: Text(
              'Send',
              style: AppTextStyles.small(color: Color(0xFF1F2D35), size: 16),
            ),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return DepositScreen();
                },
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFBC5AD7), // Purple button color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            icon: const Icon(Icons.arrow_downward, color: Color(0xFF33183A)),
            label: Text(
              'Deposit',
              style: AppTextStyles.small(color: Color(0xFF33183A), size: 16),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method to build "Other Wallets" list item
  Widget _buildOtherWalletItem({
    required IconData icon,
    required String walletName,
    required String image,
    String? walletAddress,
    required bool isConnected,
    required VoidCallback onActionPressed,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color(0xFF2A2031), // Card background color
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            image,
            width: 30,
            height: 30,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  walletName,
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (walletAddress != null)
                  Text(
                    walletAddress,
                    style: AppTextStyles.small(color: Colors.grey, size: 12),
                  )
                else if (!isConnected)
                  Text(
                    'Not Connected',
                    style: AppTextStyles.small(color: Colors.grey, size: 12),
                  ),
              ],
            ),
          ),
          TextButton(
            onPressed: onActionPressed,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isConnected ? Icons.logout : Icons.add,
                  size: 16,
                  color:
                      isConnected ? Color(0xFFF71756) : const Color(0xFFFDEB56),
                ),
                const SizedBox(width: 6),
                Text(
                  isConnected ? 'Disconnect' : 'Connect',
                  style: AppTextStyles.small(
                    color: isConnected
                        ? Color(0xFFF71756)
                        : const Color(0xFFFDEB56),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Back button with circular background
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF2D2B3A),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
            ),
          ),

          // Title centered
          Expanded(
            child: Center(
              child: Text(
                'Wallet',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Spacer to balance the back button
          const SizedBox(width: 40),
        ],
      ),
    );
  }
}
