import 'package:flutter/material.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';

class SendScreen extends StatelessWidget {
  const SendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF100613),
        appBar: const CustomAppBar(
          title: 'Send',
          titleFontSize: 12,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Send",
                  style: AppTextStyles.small(
                      size: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(height: 8),
                // Warning text
                Text(
                  'Ensure you are transferring your funds to the correct '
                  'wallet address and using the appropriate network for the '
                  'transaction.',
                  style: AppTextStyles.small(
                    color: Colors.grey,
                    size: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '*Yalgamers will be not responsible for that.',
                  style: AppTextStyles.small(
                    color: Colors.red,
                    size: 10,
                  ),
                ),
                const SizedBox(height: 32),

                // Select Coin dropdown
                _buildDropdown('Select Coin'),
                const SizedBox(height: 20),

                // Select Network dropdown
                _buildDropdown('Select Network'),
                const SizedBox(height: 24),

                // Wallet Address
                Text(
                  'Wallet Address',
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF100613),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[700]!,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    style: AppTextStyles.small(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: 'Enter your wallet address',
                      hintStyle: AppTextStyles.small(
                        color: Colors.grey,
                        size: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Amount
                Text(
                  'Amount',
                  style: AppTextStyles.small(
                    color: Colors.white,
                    size: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF100613),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey[700]!,
                      width: 1,
                    ),
                  ),
                  child: TextField(
                    style: AppTextStyles.small(color: Colors.white),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Amount',
                      hintStyle: AppTextStyles.small(
                        color: Colors.grey,
                        size: 14,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Center(
                          widthFactor: 1,
                          child: Text(
                            'MAX',
                            style: AppTextStyles.small(
                              color: Colors.blue,
                              size: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      suffixIconConstraints: const BoxConstraints(),
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // Network Fee and Receive Amount
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Network Fee',
                      style: AppTextStyles.small(
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                    Text(
                      '0.05 USDT',
                      style: AppTextStyles.small(
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Receive Amount',
                      style: AppTextStyles.small(
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                    Text(
                      '0.0 USDT',
                      style: AppTextStyles.small(
                        color: Colors.grey,
                        size: 16,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 48),

                // Send Button
                PrimaryButton(
                    label: 'Send',
                    onPressed: () {
                      showUSDTSuccessDialog(context, "150", "adfsgf");
                    }),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ));
  }

  Widget _buildDropdown(String hint) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF100613),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          hint: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Text(
              hint,
              style: AppTextStyles.small(
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
          isExpanded: true,
          dropdownColor: const Color(0xFF1A1A2E),
          icon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Icon(
              Icons.keyboard_arrow_down,
              color: Colors.grey[500],
            ),
          ),
          items: const [],
          onChanged: (value) {},
        ),
      ),
    );
  }
}

class USDTSuccessDialog extends StatelessWidget {
  final String amount;
  final String address;

  const USDTSuccessDialog({
    Key? key,
    required this.amount,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1C121F),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(32),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Green checkmark icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: const Icon(
              Icons.check,
              color: Colors.black,
              size: 40,
              weight: 4,
            ),
          ),

          const SizedBox(height: 24),

          // Title
          Text(
            'USDT Sent!',
            style: AppTextStyles.small(
              size: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 16),

          // Message
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTextStyles.small(
                size: 16,
                color: Color(0xFF9E9E9E),
              ),
              children: [
                TextSpan(text: '$amount USDT was sent to '),
                TextSpan(
                  text: address,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const TextSpan(text: '\nSuccessfully.'),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // OK Button (optional)
        ],
      ),
    );
  }
}

// Example usage function
void showUSDTSuccessDialog(
    BuildContext context, String amount, String address) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return USDTSuccessDialog(
        amount: amount,
        address: address,
      );
    },
  );
}
