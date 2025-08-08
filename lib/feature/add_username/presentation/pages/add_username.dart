import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/login/presentation/widgets/text_form_field.dart';
import 'package:yalgamers/feature/sign_up/presentation/widgets/titled_appbar.dart';
import 'package:yalgamers/feature/upload_profile_img/presentation/pages/upload_profile_img.dart';

class AddUserNameScreen extends StatefulWidget {
  const AddUserNameScreen({super.key});

  @override
  State<AddUserNameScreen> createState() => _AddUserNameScreenState();
}

class _AddUserNameScreenState extends State<AddUserNameScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isButtonEnabled = false;
  bool _isAutoClicked = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_updateButtonState);
    _usernameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.trim().isNotEmpty &&
          _usernameController.text.trim().isNotEmpty;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _onAutoIconClicked() {
    setState(() {
      _isAutoClicked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              const TitleAppbar(
                  title: 'Welcome to yalgamers!',
                  subtitle: 'Enter your details to continue'),
              Container(
                color: const Color(0xFF100613),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height * 0.7,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Name',
                          style: AppTextStyles.small(
                            color: Colors.white60,
                            size: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          controller: _nameController,
                          hintText: "Enter your name",
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Username',
                          style: AppTextStyles.small(
                            color: Colors.white60,
                            size: 14,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AppTextFormField(
                          hintText: 'Enter your username',
                          controller: _usernameController,
                          keyboardType: TextInputType.name,
                          suffixIcon: Icon(
                            _isAutoClicked
                                ? Icons.refresh_rounded
                                : Icons.auto_awesome_outlined,
                            color: Colors.amber[200],
                          ),
                          optionalSuffixText:
                              _isAutoClicked ? 'Regenerate' : 'Auto',
                          onPressed: _onAutoIconClicked,
                        ),
                        if (_isAutoClicked) ...[
                          const SizedBox(height: 15),
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 10),
                          AppTextFormField(
                            controller: _emailController,
                            hintText: "Enter your email",
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ],
                        const SizedBox(height: 20),
                        const Spacer(),
                        PrimaryButton(
                            gradient:
                                _isButtonEnabled ? buttonGradience() : null,
                            textColor:
                                _isButtonEnabled ? Colors.black : Colors.white,
                            label: 'Continue',
                            onPressed: () {
                              _isButtonEnabled
                                  ? Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                      return const SetupProfilePictureScreen();
                                    }))
                                  : null;
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
