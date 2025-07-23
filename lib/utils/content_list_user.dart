import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_text.dart';

class ContentListUser extends StatelessWidget {
  final String title;
  final String subtitle;
  final String email;
  final String imageUrl;

  const ContentListUser({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.email,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: Image.asset(imageUrl).image,
          ),
          10.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(text: title, fontSize: 15, color: AppColors.container),
              CustomText(
                text: subtitle,
                fontSize: 15,
                color: AppColors.container,
              ),
              CustomText(text: email, fontSize: 15, color: AppColors.container),
            ],
          ),
        ],
      ),
    );
  }
}
