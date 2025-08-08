import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yalgamers/core/constants/token_service.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/forgot_password/presentation/pages/forgot_password.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_bloc.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_event.dart';
import 'package:yalgamers/feature/login/google_auth/bloc/google_sign_in_state.dart';
import 'package:yalgamers/feature/login/metamask_auth/meta.dart';
import 'package:yalgamers/feature/login/presentation/widgets/header.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/social_icon.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_aligned_left.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/otp&pwd/presentation/pages/setup_password.dart';
import 'package:yalgamers/feature/sign_up/presentation/pages/google_setup_password.dart';
import 'package:yalgamers/feature/sign_up/presentation/pages/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = true;
  bool _isFieldFocused = false;
  bool _isFormFilled = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailFocus.addListener(_updateFocus);
    _passwordFocus.addListener(_updateFocus);
    _emailController.addListener(_checkFormFilled);
    _passwordController.addListener(_checkFormFilled);
  }

  void _updateFocus() {
    setState(() {
      _isFieldFocused = _emailFocus.hasFocus || _passwordFocus.hasFocus;
    });
  }

  void _checkFormFilled() {
    setState(() {
      _isFormFilled = _emailController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) return;

    setState(() {
      _isLoading = true;
    });

    // Show modal loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.buttonText),
        ),
      ),
    );

    try {
      final pb = PocketBase('https://devdash.yalgamers.gg');
      final authData =
          await pb.collection('users').authWithPassword(email, password);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loader

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const SelectLayoutScreen()),
      );
    } catch (e) {
      Navigator.of(context, rootNavigator: true).pop(); // Dismiss loader

      String errorMessage = "Login failed. Please try again.";
      if (e is ClientException &&
          e.response != null &&
          e.response['message'] != null) {
        errorMessage = e.response['message'];
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraints.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isFieldFocused) const Header(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const LeftAlignedLabelText(
                                  text: "Login",
                                  color: AppColors.textPrimary,
                                  fontSize: 24,
                                ),
                                const SizedBox(height: 8),
                                const LeftAlignedLabelText(
                                  text: "Enter your details to login",
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                ),
                                const SizedBox(height: 24),
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
                                  onChanged: (_) => _checkFormFilled(),
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
                                  focusNode: _passwordFocus,
                                  controller: _passwordController,
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
                                  onChanged: (_) => _checkFormFilled(),
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
                                    textColor: _isFormFilled
                                        ? Colors.black
                                        : Colors.white,
                                    label: 'Login',
                                    gradient: _isFormFilled
                                        ? buttonGradience()
                                        : null,
                                    onPressed: () {
                                      _isFormFilled && !_isLoading
                                          ? _handleLogin()
                                          : null;
                                    }),
                                const SizedBox(height: 24),
                                Row(
                                  children: [
                                    const Expanded(
                                        child:
                                            Divider(color: AppColors.border)),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8),
                                      child: Text(
                                        'Or Continue With',
                                        style: AppTextStyles.medium(
                                          size: 14,
                                          color: AppColors.textHint,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                        child:
                                            Divider(color: AppColors.border)),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BlocListener<GoogleSignInBloc,
                                        GoogleSignInState>(
                                      listener: (context, state) async {
                                        if (state is GoogleSignInLoading) {
                                          showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (_) => const Center(
                                              child: CircularProgressIndicator(
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                            Color>(
                                                        AppColors.buttonText),
                                              ),
                                            ),
                                          );
                                        } else if (state
                                            is GoogleSignInSuccess) {
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop();
                                          const storage =
                                              FlutterSecureStorage();
                                          final userJson =
                                              await storage.read(key: 'user');
                                          final userMap = jsonDecode(userJson!);

                                          final bool passwordAdded =
                                              userMap['passwordAdded'] ?? false;

                                          if (passwordAdded) {
                                            //  Refresh token after setting password
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const SelectLayoutScreen()),
                                            );
                                          } else {
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      const SelectLayoutScreen()),
                                            );
                                          }
                                        } else if (state
                                            is GoogleSignInFailure) {
                                          log('error is ${state.message}');
                                          Navigator.of(context,
                                                  rootNavigator: true)
                                              .pop(); // Close loading dialog
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                                content: Text(
                                                    'error ${state.message}')),
                                          );
                                        }
                                      },
                                      child: GestureDetector(
                                        onTap: () => context
                                            .read<GoogleSignInBloc>()
                                            .add(StartGoogleSignIn()),
                                        child: const SocialIcon(
                                            assetPath:
                                                'assets/icons/google-icon.png'),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Add this import at the top of your login_screen.dart

// Replace the MetaMask InkWell widget in your build method with this:

                                    InkWell(
                                      onTap: () async {
                                        try {
                                          final walletService =
                                              WalletAuthService();
                                          final success = await walletService
                                              .connectAndLogin(context);

                                          if (success) {
                                            // Optional: Show success message
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    'Wallet connection initiated. Please check your MetaMask app.'),
                                                backgroundColor: Colors.orange,
                                              ),
                                            );
                                            // Navigator.of(context)
                                            //     .pushReplacement(
                                            //   MaterialPageRoute(
                                            //     builder: (context) =>
                                            //         SetupPasswordScreen(), // <-- your screen here
                                            //   ),
                                            // );
                                            // You can add navigation logic here if needed
                                            // For example, navigate to home screen after successful login
                                            // Navigator.of(context).pushReplacement(
                                            //   MaterialPageRoute(builder: (context) => const SelectLayoutScreen()),
                                            // );
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Failed to connect wallet: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        }
                                      },
                                      child: const SocialIcon(
                                        assetPath:
                                            'assets/icons/metamask-icon.png',
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    const SocialIcon(
                                        assetPath: 'assets/icons/x-icon.png'),
                                  ],
                                ),
                                const SizedBox(height: 24),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Don't have an account? ",
                                    style: AppTextStyles.medium(
                                        color: AppColors.textNormal),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.of(context).push(
                                      //   MaterialPageRoute(
                                      //       builder: (_) =>
                                      //           const SignUpScreen()),
                                      // );
                                    },
                                    child: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          const LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          Color(0xFFF71756),
                                          Color(0xFFFDEB56),
                                        ],
                                      ).createShader(Rect.fromLTWH(0, 0,
                                              bounds.width, bounds.height)),
                                      child: Text(
                                        "Sign Up",
                                        style: AppTextStyles.medium(
                                            size: 16, color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_isLoading)
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(AppColors.buttonText),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
