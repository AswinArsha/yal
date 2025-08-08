import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_aligned_left.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/otp&pwd/presentation/pages/enter_otp.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isValidEmail = false;
  bool _showError = false;

  void _validateEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    setState(() {
      _isValidEmail = emailRegex.hasMatch(value.trim());
      _showError = !_isValidEmail && value.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.background,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white10,
                      radius: 20,
                      child: BackButton(color: Colors.white),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Forgot your password?',
                  style: AppTextStyles.medium(
                    size: 24,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Enter the email connected with your account, we will send an OTP on your mail.',
                  style: AppTextStyles.small(
                    size: 14,
                    fontWeight: FontWeight.w400,
                    color: AppColors.buttonText,
                  ),
                ),
                const SizedBox(height: 24),
                const SizedBox(height: 24),
                const LeftAlignedLabelText(text: 'Email'),
                const SizedBox(height: 10),
                AppTextFormField(
                  onChanged: _validateEmail,
                  hintText: 'Enter your email',
                  controller: _emailController,
                  focusedBorder:
                      _showError ? Colors.redAccent : Colors.amber.shade200,
                  borderColor: _showError ? Colors.redAccent : Colors.white,
                  suffixIcon: _showError
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Mail Not Found",
                              style: AppTextStyles.small(
                                  color: Colors.red.shade300, size: 12),
                            ),
                            const SizedBox(width: 6),
                            Icon(Icons.clear,
                                color: Colors.red.shade300, size: 20),
                            const SizedBox(width: 6),
                          ],
                        )
                      : null,
                ),
                const Spacer(),
                PrimaryButton(
                    label: 'Continue',
                    textColor: _isValidEmail ? Colors.black : Colors.white,
                    gradient: _isValidEmail ? buttonGradience() : null,
                    onPressed: () {
                      _isValidEmail
                          ? Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                              return const EnterOtpScreen();
                            }))
                          : null;
                    }),
                const SizedBox(height: 20),
                Center(
                    child: Container(width: 50, height: 4, color: Colors.white))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
