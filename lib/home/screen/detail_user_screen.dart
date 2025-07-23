import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:register_app/home/provider/detail_user_provider.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_text.dart';

class DetailUserScreen extends StatefulWidget {
  final int userId;

  const DetailUserScreen({super.key, required this.userId});

  @override
  State<DetailUserScreen> createState() => _DetailUserScreenState();
}

class _DetailUserScreenState extends State<DetailUserScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<UserDetailProvider>(
        context,
        listen: false,
      ).fetchUserById(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: Consumer<UserDetailProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = provider.user;

          if (user == null) {
            return const Center(child: Text('User tidak ditemukan'));
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Detail User',
                  fontSize: 25,
                  color: AppColors.glass,
                ),
                20.verticalSpace,
                CustomText(
                  text: 'Username: ${user.username}',
                  fontSize: 18,
                  color: AppColors.glass,
                ),
                20.verticalSpace,
                CustomText(
                  text: 'Email: ${user.email}',
                  fontSize: 18,
                  color: AppColors.glass,
                ),
                20.verticalSpace,
                CustomText(
                  text: 'Phone: ${user.phone}',
                  fontSize: 18,
                  color: AppColors.glass,
                ),
                20.verticalSpace,
                CustomText(
                  text: 'Address: ${user.address}',
                  fontSize: 18,
                  color: AppColors.glass,
                ),

                const Spacer(),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.textHeaderColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Back',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
