import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/forgot_password/presentation/pages/forgot_password.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_aligned_left.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';

class LoginFormFields extends StatelessWidget {
  final FocusNode emailFocus;
  final FocusNode passwordFocus;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool isPasswordVisible;
  final VoidCallback togglePasswordVisibility; 
  final ValueChanged<String> onFieldChanged;

  const LoginFormFields({
    Key? key,
    required this.emailFocus,
    required this.passwordFocus,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
    required this.onFieldChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const LeftAlignedLabelText(
          text: "Email",
          fontSize: 14,
        ),
        const SizedBox(height: 5),
        AppTextFormField(
          hintText: "Enter your email",
          focusNode: emailFocus,
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: onFieldChanged,
        ),
        const SizedBox(height: 16),
        const LeftAlignedLabelText(
          text: "Password",
          color: AppColors.textSecondary,
          fontSize: 14,
        ),
        const SizedBox(height: 5),
        AppTextFormField(
          hintText: "Enter your password",
          focusNode: passwordFocus,
          controller: passwordController,
          obscureText: !isPasswordVisible,
          suffixIcon: Icon(
            isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.textHint,
          ),
          onPressed: togglePasswordVisibility, 
          onChanged: (_) {},
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (_) => const ForgotPasswordScreen()),
          ),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forgot Password?',
              style: AppTextStyles.medium(
                color: AppColors.yellow,
                size: 14,
              ),
            ),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
