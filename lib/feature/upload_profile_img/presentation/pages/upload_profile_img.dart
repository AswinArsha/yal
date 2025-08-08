import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yalgamers/core/theme/text_style.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/bottom_navigation.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/homescreen.dart';
import 'package:yalgamers/feature/homescreen/presentation/pages/select_layout.dart';
import 'package:yalgamers/feature/upload_profile_img/presentation/widgets/dotted_img.dart';

class SetupProfilePictureScreen extends StatefulWidget {
  const SetupProfilePictureScreen({super.key});

  @override
  State<SetupProfilePictureScreen> createState() =>
      _SetupProfilePictureScreenState();
}

class _SetupProfilePictureScreenState extends State<SetupProfilePictureScreen> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  void _skip() {
    Fluttertoast.showToast(
      msg: "Skipped setting profile picture",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.orange,
      textColor: Colors.white,
      fontSize: 16.0,
    );
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return const SelectLayoutScreen();
    }));
  }

  Future<void> _save() async {
    setState(() {
      _isLoading = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (!mounted) return;

    Fluttertoast.showToast(
      msg: "Sign up Successful",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green.withOpacity(0.4),
      textColor: Colors.green,
      fontSize: 16.0,
    );

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const SelectLayoutScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF100613),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Setup a Profile Picture',
                    style: AppTextStyles.medium(
                      color: Colors.white,
                      size: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Setup a profile picture to get a good vibe.',
                    style: AppTextStyles.small(
                      color: Colors.white60,
                      size: 14,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  const SizedBox(height: 40),
                  Expanded(
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomPaint(
                            size: const Size(250, 250),
                            painter: DottedCirclePainter(),
                          ),
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.white10,
                            backgroundImage: _profileImage != null
                                ? FileImage(_profileImage!)
                                : null,
                            child: _profileImage == null
                                ? const Icon(Icons.person,
                                    size: 60, color: Colors.white38)
                                : null,
                          ),
                          if (_profileImage == null)
                            Positioned(
                              bottom: 75,
                              right: 60,
                              child: GestureDetector(
                                onTap: _pickImage,
                                child: Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.grey,
                                  ),
                                  child: const Icon(Icons.image,
                                      size: 22, color: Colors.black),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24.0, vertical: 20),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading ? null : _skip,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white24,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              'Skip',
                              style: AppTextStyles.small(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _isLoading
                                ? null
                                : (_profileImage == null ? _pickImage : _save),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _profileImage == null
                                  ? Colors.yellow
                                  : Colors.green,
                              foregroundColor: Colors.black,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                            child: Text(
                              _profileImage == null ? 'Upload Image' : 'Save',
                              style: AppTextStyles.small(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black54,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
