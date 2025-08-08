import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String selectedLanguage = 'English';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1422),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1422),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors.baseWhite,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Settings",
          style: AppTextStyles.mediumBold(
            color: AppColors.baseWhite,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Language Selection Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.baseWhite.withOpacity(0.05),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.language,
                          color: const Color.fromRGBO(157, 249, 255, 0.8),
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Language",
                          style: AppTextStyles.medium(
                            fontWeight: FontWeight.w500,
                            size: 16,
                            color: AppColors.baseWhite.withOpacity(0.9),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Language Options
                    _buildLanguageOption('English', 'English'),
                    const SizedBox(height: 12),
                    _buildLanguageOption('Arabic', 'العربية'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Settings Options
              _buildSettingsOption(
                icon: Icons.info_outline,
                iconColor: const Color.fromRGBO(253, 235, 86, 0.8),
                title: "About",
                onTap: () => _showAboutDialog(context),
              ),
              const SizedBox(height: 12),
              
              _buildSettingsOption(
                icon: Icons.privacy_tip_outlined,
                iconColor: const Color.fromRGBO(229, 125, 255, 0.8),
                title: "Privacy Policy",
                onTap: () => _showPrivacyPolicyDialog(context),
              ),
              const SizedBox(height: 12),
              
              _buildSettingsOption(
                icon: Icons.help_outline,
                iconColor: const Color.fromRGBO(157, 249, 255, 0.8),
                title: "Help & Support",
                onTap: () {
                  // Navigate to support or show help dialog
                },
              ),
              const SizedBox(height: 12),
              
              _buildSettingsOption(
                icon: Icons.star_outline,
                iconColor: const Color.fromRGBO(253, 235, 86, 0.8),
                title: "Rate App",
                onTap: () {
                  // Navigate to app store rating
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String value, String displayText) {
    final isSelected = selectedLanguage == value;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedLanguage = value;
        });
        // Here you would typically call your localization logic
        // e.g., context.read<LocalizationBloc>().add(ChangeLanguage(value));
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected 
              ? const Color.fromRGBO(253, 235, 86, 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected 
                ? const Color.fromRGBO(253, 235, 86, 0.3)
                : AppColors.baseWhite.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected 
                      ? const Color.fromRGBO(253, 235, 86, 1)
                      : AppColors.baseWhite.withOpacity(0.3),
                  width: 2,
                ),
                color: isSelected 
                    ? const Color.fromRGBO(253, 235, 86, 1)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 12,
                      color: Color(0xFF1C1422),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Text(
              displayText,
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w400,
                size: 14,
                color: isSelected 
                    ? const Color.fromRGBO(253, 235, 86, 1)
                    : AppColors.baseWhite.withOpacity(0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsOption({
    required IconData icon,
    required Color iconColor,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.border,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.baseWhite.withOpacity(0.05),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: iconColor,
              size: 20,
            ),
            const SizedBox(width: 12),
            Text(
              title,
              style: AppTextStyles.medium(
                fontWeight: FontWeight.w400,
                size: 14,
                color: AppColors.baseWhite.withOpacity(0.8),
              ),
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward_ios_outlined,
              size: 12,
              color: AppColors.baseWhite.withOpacity(0.6),
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1422),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.baseWhite.withOpacity(0.1),
            width: 1,
          ),
        ),
        title: Text(
          "About YalGamers",
          style: AppTextStyles.mediumBold(
            color: AppColors.baseWhite,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Version: 1.0.0",
              style: AppTextStyles.medium(
                color: AppColors.baseWhite.withOpacity(0.7),
                size: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "YalGamers is your ultimate gaming companion. Connect with fellow gamers, track your achievements, and level up your gaming experience.",
              style: AppTextStyles.medium(
                color: AppColors.baseWhite.withOpacity(0.8),
                size: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "© 2024 YalGamers. All rights reserved.",
              style: AppTextStyles.small(
                color: AppColors.baseWhite.withOpacity(0.6),
                size: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: AppTextStyles.medium(
                color: const Color.fromRGBO(253, 235, 86, 1),
                size: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPrivacyPolicyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1422),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: AppColors.baseWhite.withOpacity(0.1),
            width: 1,
          ),
        ),
        title: Text(
          "Privacy Policy",
          style: AppTextStyles.mediumBold(
            color: AppColors.baseWhite,
            size: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Data Collection",
                style: AppTextStyles.medium(
                  color: const Color.fromRGBO(253, 235, 86, 1),
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We collect information you provide directly to us, such as when you create an account, update your profile, or contact us for support.",
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.8),
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Data Usage",
                style: AppTextStyles.medium(
                  color: const Color.fromRGBO(253, 235, 86, 1),
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We use the information we collect to provide, maintain, and improve our services, process transactions, and communicate with you.",
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.8),
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Data Security",
                style: AppTextStyles.medium(
                  color: const Color.fromRGBO(253, 235, 86, 1),
                  size: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "We take reasonable measures to protect your information from unauthorized access, use, or disclosure.",
                style: AppTextStyles.medium(
                  color: AppColors.baseWhite.withOpacity(0.8),
                  size: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Close",
              style: AppTextStyles.medium(
                color: const Color.fromRGBO(253, 235, 86, 1),
                size: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}