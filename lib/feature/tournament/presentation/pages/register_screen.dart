import 'package:flutter/material.dart';
import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: CustomAppBar(title: "Registration"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF1E1923),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/images/bg/pubg-registration.png',
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Registering for",
                        style: AppTextStyles.small(
                          size: 14,
                          color: Colors.yellow,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "PUBG Mobile Mena Summer",
                        style: AppTextStyles.small(
                          size: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const CustomInputField(label: 'Game UID'),
            const SizedBox(height: 16),
            const CustomInputField(label: 'Email'),
            const SizedBox(height: 16),
            const CustomInputField(label: 'Discord'),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF332A36),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 👈 Curve here
                      ),
                    ),
                    child: Text('Cancel',
                        style: AppTextStyles.small(color: Colors.white)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Submit logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF1FD031),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6), // 👈 Curve here
                      ),
                    ),
                    child: Text('Register',
                        style: AppTextStyles.small(
                            size: 14,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF07280A))),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String label;

  const CustomInputField({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label, // This is the title above the field
          style: AppTextStyles.small(color: Colors.white),
        ),
        const SizedBox(height: 6),
        TextField(
          style: AppTextStyles.small(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Enter your ${label.toLowerCase()}',
            hintStyle: AppTextStyles.small(color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.yellow),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ],
    );
  }
}
