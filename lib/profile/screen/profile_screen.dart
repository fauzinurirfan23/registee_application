import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:register_app/profile/provider/profile_provider.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_text.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    loadUserId();
  }

  Future<void> loadUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId != null) {
      Provider.of<ProfileProvider>(
        context,
        listen: false,
      ).fetchProfileById(userId);
    } else {
      print('UserId not found in SharedPreferences');
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<ProfileProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = provider.profile;

          if (profile == null) {
            return const Center(child: Text('Profile not found'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 120),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      backgroundImage:
                          _imageFile != null ? FileImage(_imageFile!) : null,
                      child:
                          _imageFile == null
                              ? Text(
                                (profile.username?.isNotEmpty ?? false)
                                    ? profile.username!
                                        .substring(0, 2)
                                        .toUpperCase()
                                    : 'NA',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                              : null,
                    ),
                  ),
                  20.verticalSpace,
                  CustomText(
                    text: 'Username: ${profile.username}',
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                  CustomText(
                    text: 'Email: ${profile.email}',
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                  CustomText(
                    text: 'Phone: ${profile.phone}',
                    fontSize: 20,
                    color: AppColors.white,
                  ),
                  if (profile.address != null)
                    CustomText(
                      text: 'Address: ${profile.address}',
                      textAlign: TextAlign.center,
                      fontSize: 20,
                      color: AppColors.white,
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
