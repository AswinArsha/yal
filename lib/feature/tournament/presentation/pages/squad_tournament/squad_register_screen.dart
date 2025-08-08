// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:yalgamers/core/constants/common_widgets/custom_app_bar.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SquadRegisterScreen extends StatelessWidget {
  const SquadRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      appBar: CustomAppBar(title: "Registration"),
      body: SingleChildScrollView(
        child: Padding(
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
              const SizedBox(height: 12),
              Divider(
                height: 0,
                color: Color(0xFF1C131F),
              ),
              const SizedBox(height: 12),
              TitleRegistation(playerTitle: "My Details", captain: "captain"),
              const SizedBox(height: 6),
              const CustomInputField(label: 'Game UID'),
              const SizedBox(height: 16),
              const CustomInputField(label: 'Email'),
              const SizedBox(height: 16),
              const CustomInputField(label: 'Discord'),
              const SizedBox(height: 12),
              Divider(
                color: Color(0xFF1C131F),
              ),
              TitleRegistation(
                playerTitle: "Player 2",
                showCaptain: false,
              ),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Email'),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Game UID'),
              const SizedBox(height: 16),
              Divider(
                color: Color(0xFF1C131F),
              ),
              TitleRegistation(
                playerTitle: "Player 3",
                showCaptain: false,
              ),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Email'),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Game UID'),
              const SizedBox(height: 16),
              Divider(
                color: Color(0xFF1C131F),
              ),
              TitleRegistation(
                playerTitle: "Player 4",
                showCaptain: false,
              ),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Email'),
              const SizedBox(height: 12),
              const CustomInputField(label: 'Game UID'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF332A36),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
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
                          borderRadius:
                              BorderRadius.circular(6), // 👈 Curve here
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

class TitleRegistation extends StatelessWidget {
  final String playerTitle;
  final String? captain;
  final bool showCaptain; // <-- NEW

  const TitleRegistation({
    super.key,
    required this.playerTitle,
    this.captain,
    this.showCaptain = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          playerTitle,
          style: AppTextStyles.small(color: Colors.white),
        ),
        if (showCaptain)
          Row(
            children: [
              const Icon(
                Icons.star,
                color: Color(0xFFD4AF37),
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                captain ?? "",
                style: AppTextStyles.small(
                  color: Color(0xFFD4AF37),
                  size: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
