import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yalgamers/core/constants/common_widgets/success_dialog.dart';
import 'package:yalgamers/core/theme/app_colors.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/login/presentation/widgets/login_button.dart';
import 'package:yalgamers/feature/quest/presentation/pages/task_screen.dart';
import 'package:yalgamers/feature/quest/presentation/widgets/luminous_card.dart';
import 'package:yalgamers/feature/xp_mystery/presentation/pages/xp_mystery.dart';

class CreatePostDialog extends StatefulWidget {
  const CreatePostDialog({super.key});

  @override
  State<CreatePostDialog> createState() => _CreatePostDialogState();
}

class _CreatePostDialogState extends State<CreatePostDialog> {
  final TextEditingController _captionController = TextEditingController();
  XFile? _selectedImage;

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _selectedImage = image;
      });
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(28, 21, 30, 1),
              borderRadius: BorderRadius.circular(6),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
            ),
            padding: EdgeInsets.all(12.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 8.h),
                Text('Create New Post',
                    style: AppTextStyles.largeBold(
                        color: Colors.white,
                        size: 16,
                        fontWeight: FontWeight.w600)),
                const Divider(
                    thickness: 0.5, color: Color.fromRGBO(253, 235, 86, 0.08)),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => XPMysteryScreen())),
                  child: _buildProfileTile(context,
                      title: 'Haninah',
                      value: '@haninah778',
                      tileColor: const Color.fromRGBO(253, 235, 86, 0.08)),
                ),
                SizedBox(height: 12.h),
                _buildDropdown(),
                SizedBox(height: 12.h),
                SizedBox(
                  height: _selectedImage == null ? 120.h : null,
                  child: TextField(
                    controller: _captionController,
                    style: AppTextStyles.small(
                        size: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.baseWhite.withOpacity(0.8)),
                    maxLines: null,
                    decoration: InputDecoration.collapsed(
                        hintText: 'What do you want to share today?',
                        hintStyle: AppTextStyles.medium(
                            size: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.baseWhite.withOpacity(0.3))),
                  ),
                ),
                _selectedImage == null
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: _pickImage,
                            child: const IntrinsicWidth(
                              child: LuminousCard(
                                fontSize: 12,
                                iconSize: 16,
                                padding: EdgeInsets.all(6),
                                prefixIcon: Icons.image_outlined,
                                luminousColor: Color.fromRGBO(142, 201, 237, 1),
                                label: 'Add Image',
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
                if (_captionController.text.isNotEmpty ||
                    _selectedImage != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_selectedImage != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.file(
                              File(_selectedImage!.path),
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                    ],
                  ),
                SizedBox(height: 16.h),
                PrimaryButton(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  label: 'Post',
                  onPressed: () {
                    Navigator.of(context).pop();

                    showSuccessDialog(context, 'Posted Successfully!', '', '');
                  },
                  textColor: const Color.fromRGBO(56, 52, 17, 1),
                  backgroundColor: AppColors.xpColor,
                )
              ],
            ),
          ),
          Positioned(
            top: -10.h,
            right: -10.h,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: EdgeInsets.all(6.h),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1,
                  ),
                ),
                child: Icon(Icons.close,
                    size: 18.h, color: Colors.white.withOpacity(0.6)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
              color: AppColors.baseWhite.withOpacity(0.05), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
              color: AppColors.baseWhite.withOpacity(0.05), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(
              color: AppColors.baseWhite.withOpacity(0.05), width: 1),
        ),
      ),
      iconSize: 16,
      style: AppTextStyles.small(
          size: 12, fontWeight: FontWeight.w400, color: AppColors.baseWhite),
      hint: Text('Select Category',
          style: AppTextStyles.small(
              size: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.baseWhite.withOpacity(0.7))),
      items: [], // TODO: Add your items
      onChanged: (value) {},
    );
  }

  Widget _buildProfileTile(
    BuildContext context, {
    required String title,
    required String value,
    required Color tileColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.baseWhite.withOpacity(0.03),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Row(
          children: [
            const CircleAvatar(backgroundImage: AssetImage('assets/user.png')),
            SizedBox(width: 8.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTextStyles.medium(
                        color: AppColors.baseWhite.withOpacity(0.9),
                        fontWeight: FontWeight.w500,
                        size: 14)),
                SizedBox(height: 4.h),
                Text(value,
                    style: AppTextStyles.small(
                        color: const Color.fromRGBO(126, 110, 131, 1),
                        size: 10,
                        fontWeight: FontWeight.w400)),
              ],
            ),
            const Spacer(),
            Icon(Icons.check_circle, color: Colors.green, size: 16.h),
            SizedBox(width: 4.h),
            Text('Active',
                style: AppTextStyles.small(
                    size: 12, fontWeight: FontWeight.w400, color: Colors.green))
          ],
        ),
      ),
    );
  }
}
