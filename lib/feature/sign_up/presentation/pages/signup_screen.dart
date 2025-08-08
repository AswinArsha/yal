import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/forgot_password/presentation/pages/forgot_password.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/login/presentation/pages/login_screen.dart';
import 'package:yalgamers/feature/login/presentation/widgets/header.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/social_icon.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_aligned_left.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/sign_up/presentation/bloc/signup_bloc.dart';
import 'package:yalgamers/feature/sign_up/presentation/pages/google_setup_password.dart';
import 'package:yalgamers/feature/sign_up/presentation/pages/verify_email.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmPasswordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = true;
  bool _isConfirmPasswordVisible = true;

  bool _isButtonEnabled = false;

  bool _isFieldFocused = false;
  void _validateFields() {
    setState(() {
      _isButtonEnabled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;
    });
  }

  void initState() {
    super.initState();
    _emailFocus.addListener(_updateFocus);
    _passwordFocus.addListener(_updateFocus);

    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
  }

  void _updateFocus() {
    setState(() {
      _isFieldFocused = _emailFocus.hasFocus ||
          _passwordFocus.hasFocus ||
          _confirmPasswordFocus.hasFocus;
    });
  }

  @override
  void dispose() {
    _confirmPasswordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User Created Successfully')),
          );
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const VerifyEmailScreen()),
          );
        } else if (state is SignupFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is SignupLoading) {
          return const CircularProgressIndicator();
        }

        return Scaffold(
          backgroundColor: const Color(0xFF100613),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (!_isFieldFocused) const Header(),
                  Container(
                    color: const Color(0xFF100613),
                    child: Column(
                      children: [
                        Container(
                          color: _isFieldFocused
                              ? const Color.fromARGB(255, 42, 39, 42)
                              : const Color(0xFF100613),
                          child: const Padding(
                            padding:
                                EdgeInsets.only(top: 16, left: 12, right: 12),
                            child: Column(
                              children: [
                                LeftAlignedLabelText(
                                  text: "Sign Up",
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                ),
                                SizedBox(height: 8),
                                LeftAlignedLabelText(
                                  text: "Enter your details to Sign up",
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                                SizedBox(height: 24),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          child: Column(
                            children: [
                              const LeftAlignedLabelText(
                                text: "Email",
                                fontSize: 14,
                              ),
                              const SizedBox(height: 5),
                              AppTextFormField(
                                hintText: "Enter your email",
                                focusNode: _emailFocus,
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              const SizedBox(height: 16),
                              const LeftAlignedLabelText(
                                text: "Password",
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                              const SizedBox(height: 5),
                              AppTextFormField(
                                controller: _passwordController,
                                hintText: "Enter your password",
                                focusNode: _passwordFocus,
                                obscureText: !_isPasswordVisible,
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
                                // onChanged: (_) => _checkFormFilled(),
                              ),
                              const SizedBox(height: 16),
                              const LeftAlignedLabelText(
                                text: "Confirm Password",
                                color: AppColors.textSecondary,
                                fontSize: 14,
                              ),
                              const SizedBox(height: 5),
                              AppTextFormField(
                                controller: _confirmPasswordController,
                                hintText: "Enter your password",
                                focusNode: _confirmPasswordFocus,
                                obscureText: !_isConfirmPasswordVisible,
                                suffixIcon: Icon(
                                  _isConfirmPasswordVisible
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
                              const SizedBox(height: 12),
                              GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          const ForgotPasswordScreen()),
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
                              PrimaryButton(
                                label: 'Sign Up',
                                gradient:
                                    _isButtonEnabled ? buttonGradience() : null,
                                textColor: _isButtonEnabled
                                    ? Colors.black
                                    : Colors.white,
                                onPressed: () async {
                                  if (!_isButtonEnabled) return;

                                  context.read<SignupBloc>().add(SignUp(
                                        email: _emailController.text.trim(),
                                        password:
                                            _passwordController.text.trim(),
                                      ));
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const Expanded(
                                  child: Divider(color: AppColors.border)),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text('Or Continue With',
                                    style: AppTextStyles.medium(
                                        size: 14,
                                        color: AppColors.textHint,
                                        fontWeight: FontWeight.normal)),
                              ),
                              const Expanded(
                                  child: Divider(color: AppColors.border)),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  print('hello');
                                  final pb = PocketBase(
                                      'https://devdash.yalgamers.gg');

                                  final authData = await pb
                                      .collection('users')
                                      .authWithOAuth2('google', (
                                    url,
                                  ) async {
                                    // or use something like flutter_custom_tabs to make the transitions between native and web content more seamless
                                    await launchUrl(url);
                                  });

                                  if (authData.token.isNotEmpty) {
                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return const GoogleSetupPassword();
                                        },
                                      ),
                                    );
                                  }
                                },
                                child: const SocialIcon(
                                    assetPath: 'assets/icons/google-icon.png'),
                              ),
                              const SizedBox(width: 16),
                              const SocialIcon(
                                  assetPath: 'assets/icons/metamask-icon.png'),
                              const SizedBox(width: 16),
                              const SocialIcon(
                                  assetPath: 'assets/icons/x-icon.png'),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account? ",
                                style: AppTextStyles.medium(
                                    color: AppColors.textNormal),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: ShaderMask(
                                  shaderCallback: (bounds) =>
                                      const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFF71756),
                                      Color(0xFFFDEB56),
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    "Login",
                                    style: AppTextStyles.medium(
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
