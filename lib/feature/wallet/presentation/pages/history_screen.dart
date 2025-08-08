import 'package:flutter/material.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/wallet/presentation/pages/send_screen.dart';

import 'package:flutter/material.dart';

// Transaction model
class Transaction {
  final String type;
  final String status;
  final String amount;
  final String date;
  final IconData icon;
  final Color iconBgColor;

  Transaction({
    required this.type,
    required this.status,
    required this.amount,
    required this.date,
    required this.icon,
    required this.iconBgColor,
  });
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  // Sample transaction data
  List<Transaction> get transactions => [
        Transaction(
          type: "USDT Send",
          status: "Unsuccessful",
          amount: "-10 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.north_east,
          iconBgColor: const Color(0xFF4A5568),
        ),
        Transaction(
          type: "NFT Received",
          status: "Successful",
          amount: "OG",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.image,
          iconBgColor: const Color(0xFF8B5A3C),
        ),
        Transaction(
          type: "USDT Send",
          status: "Successful",
          amount: "-10 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.north_east,
          iconBgColor: const Color(0xFF4A5568),
        ),
        Transaction(
          type: "USDT Received",
          status: "Successful",
          amount: "+10.99 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.south_west,
          iconBgColor: const Color(0xFF6B46C1),
        ),
        Transaction(
          type: "USDT Received",
          status: "Successful",
          amount: "+10.99 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.south_west,
          iconBgColor: const Color(0xFF6B46C1),
        ),
        Transaction(
          type: "USDT Send",
          status: "Successful",
          amount: "-10 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.north_east,
          iconBgColor: const Color(0xFF4A5568),
        ),
        Transaction(
          type: "USDT Send",
          status: "Successful",
          amount: "-10 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.north_east,
          iconBgColor: const Color(0xFF4A5568),
        ),
        Transaction(
          type: "USDT Send",
          status: "Successful",
          amount: "-10 USDT",
          date: "12 December, 2024, 02:32pm",
          icon: Icons.north_east,
          iconBgColor: const Color(0xFF4A5568),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: CustomAppBar(title: "History"),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(top: 15, left: 20),
              child: Text(
                "Transaction History",
                style: AppTextStyles.small(
                    color: Colors.white, size: 20, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return TransactionCard(transaction: transaction);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({
    Key? key,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSuccessful = transaction.status == "Successful";
    final bool isReceived = transaction.type.contains("Received");
    final bool isNFT = transaction.type.contains("NFT");

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.03),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Icon
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: transaction.iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              transaction.icon,
              color: Colors.white,
              size: 12,
            ),
          ),

          const SizedBox(width: 16),

          // Transaction Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      transaction.type,
                      style: AppTextStyles.small(
                        color: Colors.white,
                        size: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            isSuccessful ? Icons.check_circle : Icons.cancel,
                            size: 12,
                            color: isSuccessful
                                ? const Color(0xFF10B981)
                                : const Color(0xFFEF4444),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            transaction.status,
                            style: AppTextStyles.small(
                              color: isSuccessful
                                  ? const Color(0xFF10B981)
                                  : const Color(0xFFEF4444),
                              size: 10,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  transaction.date,
                  style: AppTextStyles.small(
                      color: Color(0xFF9CA3AF),
                      size: 10,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),

          // Amount
          Text(
            transaction.amount,
            style: AppTextStyles.small(
              color: isNFT
                  ? const Color(0xFF10B981)
                  : isReceived
                      ? const Color(0xFF10B981)
                      : const Color(0xFFEF4444),
              size: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
