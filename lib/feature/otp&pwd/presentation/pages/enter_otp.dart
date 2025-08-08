import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/otp&pwd/presentation/pages/setup_password.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/otp_fields.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/titled_appbar.dart';

class EnterOtpScreen extends StatefulWidget {
  const EnterOtpScreen({super.key});

  @override
  State<EnterOtpScreen> createState() => _EnterOtpScreenState();
}

class _EnterOtpScreenState extends State<EnterOtpScreen> {
  final List<TextEditingController> otpControllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  bool _isOtpInvalid = false;

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
      _isOtpInvalid = false;
    });
  }

  void verifyOtp() {
    String enteredOtp = otpControllers.map((c) => c.text).join();
    bool isCorrectOtp = enteredOtp == "123456";
    log('message');
    if (isCorrectOtp) {
      setState(() {
        _isOtpInvalid = false;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const SetupPasswordScreen(),
          ),
        );
      });
    } else {
      setState(() {
        _isOtpInvalid = true;
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
                title: 'Enter OTP',
                subtitle: 'Enter the OTP sent to your mail'),
            Expanded(
              child: Container(
                color: const Color(0xFF100613),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Enter the 6 digit OTP we just sent to your mail',
                      style: AppTextStyles.small(color: Colors.white70),
                    ),
                    const SizedBox(height: 10),
                    OTPTextFields(
                        controllers: otpControllers,
                        focusNodes: focusNodes,
                        isOtpInvalid: _isOtpInvalid,
                        onOtpChanged: onOtpChanged),
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
                              text: 'Resend in 00:30',
                              style: AppTextStyles.verySmallWithUnderLine(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold,
                              ),
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
                          _isOtpFilled ? verifyOtp() : null;
                        }),
                    const SizedBox(height: 20),
                    Center(
                      child:
                          Container(width: 50, height: 4, color: Colors.white),
                    ),
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
