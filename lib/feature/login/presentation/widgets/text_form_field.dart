import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final FocusNode? focusNode;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onPressed;
  final String? optionalSuffixText;
  final Color? borderColor;
  final Color? focusedBorder;

  const AppTextFormField({
    super.key,
    this.borderColor,
    this.focusedBorder,
    this.onPressed,
    this.onChanged,
    required this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.suffixIcon,
    this.controller,
    this.optionalSuffixText,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    Color enabledBorderColor = borderColor ?? AppColors.border;
    Color focusedBorderColor = focusedBorder ?? Color(0XFFFDEB56);
    return TextFormField(
      onTap: onPressed,
      onChanged: onChanged,
      controller: controller,
      focusNode: focusNode,
      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: Colors.white,
      style: AppTextStyles.small(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles.medium(color: AppColors.textHint),
        filled: true,
        fillColor: Colors.transparent,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: enabledBorderColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        suffixIcon: suffixIcon != null || optionalSuffixText != null
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (suffixIcon != null) suffixIcon!,
                  const SizedBox(width: 8),
                  if (optionalSuffixText != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: Text(
                        optionalSuffixText!,
                        style: TextStyle(color: Colors.amber[200]),
                      ),
                    ),
                ],
              )
            : null,
      ),
    );
  }
}
