import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final bool showBackButton;
  final Color backgroundColor;
  final Color titleColor;
  final Color backButtonColor;
  final double titleFontSize;
  final FontWeight titleFontWeight;
  final bool showUnderline;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.showBackButton = true,
    this.backgroundColor = const Color(0xFF1C121F),
    this.titleColor = const Color(0xFF9CA3AF),
    this.backButtonColor = Colors.white,
    this.titleFontSize = 12,
    this.titleFontWeight = FontWeight.w500,
    this.showUnderline = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: showUnderline
            ? const Border(
                bottom: BorderSide(
                  color: Color(0xFF2D2B3A),
                  width: 1,
                ),
              )
            : null,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              if (showBackButton)
                InkWell(
                  onTap: onBackPressed ?? () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF2D2B3A),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back,
                      color: backButtonColor,
                      size: 20,
                    ),
                  ),
                ),

              // Title centered
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: AppTextStyles.small(
                      color: titleColor,
                      size: titleFontSize,
                      fontWeight: titleFontWeight,
                    ),
                  ),
                ),
              ),

              // Spacer to balance the back button
              if (showBackButton) const SizedBox(width: 40),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}

String capitalizeFirstLetter(String text) {
  if (text.isEmpty) return text;
  return text[0].toUpperCase() + text.substring(1);
}

class GradientFollowButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  const GradientFollowButton({super.key, required this.onPressed,required this.label});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFF71756).withOpacity(0.15),
              Color(0xFFFDEB56).withOpacity(0.15)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (Rect bounds) {
            return const LinearGradient(
              colors: [Color(0xFFF71756), Color(0xFFFDEB56)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ).createShader(bounds);
          },
          child:  Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white, // gets overridden by ShaderMask
            ),
          ),
        ),
      ),
    );
  }
}
