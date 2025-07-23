import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:register_app/home/screen/home_screen.dart';
import 'package:register_app/login/screen/sign_in_screen.dart';
import 'package:register_app/login/screen/sign_up_screen.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_container.dart';
import 'package:register_app/utils/custom_text.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 150.h),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/x.png', scale: 2),
                80.verticalSpace,
                CustomText(
                  text: 'Welcome to Voucher App',
                  fontSize: 25,
                  color: AppColors.glass,
                ),

                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignInScreen(),
                      ),
                    );
                  },
                  child: CustomContainer(
                    child: Center(
                      child: CustomText(
                        text: 'Sign in',
                        fontSize: 20,
                        color: AppColors.glass,
                      ),
                    ),
                    color: AppColors.textHeaderColor,
                  ),
                ),
                20.verticalSpace,
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: CustomContainer(
                    child: Center(
                      child: CustomText(
                        text: 'Sign up',
                        fontSize: 20,
                        color: AppColors.textHeaderColor,
                      ),
                    ),
                    color: AppColors.glass,
                  ),
                ),
                50.verticalSpace,
                CustomText(
                  text: 'Or sign in with',
                  fontSize: 20,
                  color: AppColors.glass,
                ),
                20.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset('assets/icons/instagram.png', scale: 2),

                      onPressed: () {},
                    ),
                    20.horizontalSpace,
                    IconButton(
                      icon: Image.asset('assets/icons/facebook.png', scale: 2),

                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
