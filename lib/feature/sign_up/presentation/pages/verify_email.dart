import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/add_username/presentation/pages/add_username.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/otp_fields.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/titled_appbar.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool isOtpInvalid = false;

  bool get _isOtpFilled =>
      otpControllers.every((controller) => controller.text.isNotEmpty);

  @override
  void dispose() {
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    setState(() {
      isOtpInvalid = false;
    });
  }

  void _verifyOtp() {
    String enteredOtp = otpControllers.map((c) => c.text).join();
    bool isCorrectOtp = enteredOtp == "123456";
    if (isCorrectOtp) {
      setState(() {
        isOtpInvalid = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const AddUserNameScreen(),
          ),
        );
      });
    } else {
      setState(() {
        isOtpInvalid = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const TitleAppbar(
                title: 'Verify Email',
                subtitle: 'Verify your email address to sign up.'),
            Expanded(
              child: Container(
                color: const Color(0xFF100613),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text('Enter the 6 digit OTP we just sent to your mail',
                        style: AppTextStyles.small(color: Colors.white70)),
                    const SizedBox(height: 10),
                    OTPTextFields(
                        controllers: otpControllers,
                        focusNodes: focusNodes,
                        isOtpInvalid: isOtpInvalid,
                        onOtpChanged: onOtpChanged),
                    if (isOtpInvalid) ...[
                      const SizedBox(height: 10),
                      Text(
                        'Incorrect OTP. Please try again.',
                        style: AppTextStyles.small(color: Colors.redAccent),
                      ),
                    ],
                    const SizedBox(height: 30),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: "Didn't receive the OTP yet? ",
                          style: AppTextStyles.small(
                            color: Colors.white70,
                            size: 14,
                          ),
                          children: [
                            TextSpan(
                              text: 'Resend',
                              style: AppTextStyles.verySmallWithUnderLine(
                                  size: 14,
                                  color: Color(0xFFFDEB56),
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    PrimaryButton(
                        label: 'Verify',
                        gradient: _isOtpFilled ? buttonGradience() : null,
                        textColor: _isOtpFilled ? Colors.black : Colors.white,
                        onPressed: () {
                          _isOtpFilled ? _verifyOtp() : null;
                        }),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
