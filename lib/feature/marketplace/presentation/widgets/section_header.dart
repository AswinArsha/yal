import 'package:flutter/material.dart';
import 'package:yalgamers/core/theme/text_style.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final VoidCallback onFilterPressed;

  const SectionHeader({
    Key? key,
    required this.title,
    this.subtitle,
    required this.onFilterPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Wrap with Expanded to take available width
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // <-- Important!
                children: [
                  Text(
                    title,
                    style: AppTextStyles.medium(
                      color: Colors.white,
                      size: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: AppTextStyles.small(
                        color: Colors.white60,
                        size: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                ],
              ),
            ),
            ElevatedButton.icon(
              onPressed: onFilterPressed,
              icon: const Icon(Icons.tune, size: 14),
              label: const Text('Filter'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                backgroundColor: const Color(0xFF1C131F),
                foregroundColor: Colors.white,
                side: const BorderSide(color: Color(0xFF322A35), width: 1),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                textStyle: AppTextStyles.small(size: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
