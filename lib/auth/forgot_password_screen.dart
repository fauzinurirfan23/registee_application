import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:register_app/auth/provider/forgot_password_provider.dart';
import 'package:register_app/login/screen/login_screen.dart';
import 'package:register_app/utils/colors.dart';
import 'package:register_app/utils/custom_container.dart';
import 'package:register_app/utils/custom_text.dart';
import 'package:register_app/utils/custom_textformfield.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.bgColor,
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
          height: 300.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.glass,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Consumer<ForgotPasswordProvider>(
            builder: (context, provider, _) {
              return Column(
                children: [
                  CustomTextFormField(
                    controller: usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    obscureText: false,
                    label: 'username',
                  ),
                  10.verticalSpace,
                  CustomTextFormField(
                    controller: newPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your new password';
                      }
                      return null;
                    },
                    obscureText: false,
                    label: 'new password',
                  ),
                  30.verticalSpace,
                  GestureDetector(
                    onTap: () async {
                      await Provider.of<ForgotPasswordProvider>(
                        context,
                        listen: false,
                      ).forgotPassword(
                        usernameController.text.trim(),
                        newPasswordController.text.trim(),
                      );

                      final message =
                          Provider.of<ForgotPasswordProvider>(
                            context,
                            listen: false,
                          ).message;

                      if (message != null) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(message)));

                        if (message.contains('berhasil')) {
                          Future.delayed(const Duration(seconds: 1), () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          });
                        }
                      }
                    },
                    child: CustomContainer(
                      child: Center(
                        child: CustomText(
                          text: 'Submit',
                          fontSize: 20,
                          color: AppColors.glass,
                        ),
                      ),
                      color: AppColors.textHeaderColor,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset('assets/images/x.png', scale: 3),
            ),
            20.verticalSpace,
            CustomText(
              text: 'Forgot your password?',
              fontSize: 20,
              color: AppColors.glass,
            ),
            20.verticalSpace,
            CustomText(
              text:
                  'Please enter your registered username and a new password to log in later.',
              fontSize: 20,
              color: AppColors.glass,
            ),
            25.verticalSpace,
            CustomText(
              text: 'Enjoy using the app',
              fontSize: 20,
              color: AppColors.glass,
            ),
          ],
        ),
      ),
    );
  }
}
