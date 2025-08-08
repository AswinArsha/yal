import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:yalgamers/core/db/db.dart';
import 'package:yalgamers/core/secrets/app_secrets.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_aligned_left.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/titled_appbar.dart';

class GoogleSetupPassword extends StatefulWidget {
  const GoogleSetupPassword({super.key});

  @override
  State<GoogleSetupPassword> createState() => _GoogleSetupPasswordState();
}

class _GoogleSetupPasswordState extends State<GoogleSetupPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isButtonEnabled = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_validateForm);
    _confirmPasswordController.addListener(_validateForm);
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: const Color(0xFF1C121F),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 55,
                    decoration: const BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child:
                        const Icon(Icons.check, color: Colors.black, size: 32),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Successful!',
                style: AppTextStyles.medium(
                  color: Colors.white,
                  size: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Congratulations! Your password was resetted successfully.',
                style: AppTextStyles.small(color: Colors.white70, size: 14),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pop();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const SelectLayoutScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const TitleAppbar(
                title: 'Setup a new password',
                subtitle: 'Setup a password to secure  your account'),
            Expanded(
              child: Container(
                color: const Color(0xFF100613),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),
                    const LeftAlignedLabelText(text: 'Enter a new password'),
                    const SizedBox(height: 10),
                    AppTextFormField(
                      obscureText: !_isPasswordVisible,
                      hintText: 'Enter a new password',
                      controller: _passwordController,
                      suffixIcon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    const SizedBox(height: 15),
                    const LeftAlignedLabelText(text: 'Confirm a new password'),
                    const SizedBox(height: 10),
                    AppTextFormField(
                      obscureText: !_isPasswordVisible,
                      hintText: 'Confirm a new password',
                      controller: _confirmPasswordController,
                      suffixIcon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.textHint,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                    const Spacer(),
                    PrimaryButton(
                        gradient: _isButtonEnabled ? buttonGradience() : null,
                        textColor:
                            _isButtonEnabled ? Colors.black : Colors.white,
                        label: 'Confirm',
                        onPressed: () {
                          _isButtonEnabled ? savePassword() : null;
                        }),
                    const SizedBox(height: 20),
                    Center(
                      child: Container(
                        width: 50,
                        height: 4,
                        color: Colors.white,
                      ),
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

  Future<void> savePassword() async {
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }

    final secureStorageService = SecureStorageService();

    try {
      final accessToken = await secureStorageService.getAccessToken();

      final response = await http.post(
        Uri.parse(AppUrls.savePasswordURL),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: jsonEncode({
          "password": password,
        }),
      );

      log('body is ${response.body}');

      if (response.statusCode == 201 || response.statusCode == 200) {
        _showSuccessDialog();
      } else {
        final message =
            jsonDecode(response.body)['message'] ?? 'Something went wrong';
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      log('eror is $e');
    }
  }
}
